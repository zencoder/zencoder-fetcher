require 'rubygems'
require 'httparty'
require 'json'

module ZencoderFetcher
  FETCHER_VERSION = [0,1] unless defined?(FETCHER_VERSION)
  
  def self.version
    FETCHER_VERSION.join(".")
  end
  
  def self.request(options={})
    api_key = options[:api_key]
    post_uri = options[:url] ? options[:url] : "http://localhost:3000/"
    per_page = options[:count] ? options[:count] : 50
    page = options[:page] ? options[:page] : 1
    
    begin
      response = HTTParty.get("http://app.zencoder.com/api/notifications.json?api_key=#{api_key}&per_page=#{per_page}&page=#{page}")
      if response.is_a?(String)
        if response.body =~ /\{"errors"/
          puts JSON.parse(response.body)["errors"]
        else
          i = 0
          JSON.parse(response).each do |job|
            options = {:headers => {"Content-type" => "application/json"}, :body => job}
            HTTParty.post(post_uri, options)
            i += 1
          end
          puts "#{i} notifications retrieved and posted to #{post_uri}"
        end
      else
        puts "No notifications found."
      end
    rescue Exception => e
      raise e
    end
  end
end