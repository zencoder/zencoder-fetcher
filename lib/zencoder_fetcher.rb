require 'rubygems'
require 'httparty'
require 'json'
require 'time'

module ZencoderFetcher
  FETCHER_VERSION = [0,2] unless defined?(FETCHER_VERSION)

  def self.version
    FETCHER_VERSION.join(".")
  end

  def self.request(options={})
    query = {
      "api_key"  => options[:api_key],
      "per_page" => options[:count] || 50,
      "page"     => options[:page] || 1
    }
    query["since"] = options[:since].iso8601 if options[:since]
    query = query.map{|k,v| "#{k}=#{v}" }.join("&")

    local_url = options[:url] || "http://localhost:3000/"

    response = HTTParty.get("https://#{options[:endpoint] || 'app'}.zencoder.com/api/notifications.json?#{query}",
                            :headers => { "HTTP_X_FETCHER_VERSION" => version })

    if response["errors"]
      puts "There was an error fetching notifications:"
      puts response.body.to_s
      raise
    else
      response["notifications"].each do |notification|
        begin
          HTTParty.post(local_url,
                        :body => notification.to_json,
                        :headers => { "Content-type" => "application/json" })
        rescue Errno::ECONNREFUSED => e
          puts "Unable to connect to your local server at #{local_url}. Is it running?"
          raise FetcherLocalConnectionError
        end
      end
      puts "Notifications retrieved: #{response["notifications"].size}"
      puts "Posted to: #{local_url}" if response["notifications"].size > 0
      puts

      Time.parse(response["sent_at"])
    end
  end
end


class FetcherError < StandardError; end
class FetcherLocalConnectionError < FetcherError; end
