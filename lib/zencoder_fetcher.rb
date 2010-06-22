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
    since_job_id = (options[:all] || options[:since_job_id].to_s == "") ? 0 : options[:since_job_id]
    
    begin
      response = HTTParty.get("http://app.zencoder.com/api/notifications.json?api_key=#{api_key}&per_page=#{per_page}&page=#{page}&since_id=#{since_job_id}")
      
      if response.body.is_a?(String)
        if response.body =~ /\{"errors"/
          puts JSON.parse(response.body)["errors"]
        else
          i = 0
          latest_job_id = 0
          JSON.parse(response.body).each do |job|
            options = {:headers => {"Content-type" => "application/json"}, :body => job.to_json}
            HTTParty.post(post_uri, options)
            latest_job_id = JSON.parse(job)["job"]["id"].to_i if JSON.parse(job)["job"]["id"].to_i > latest_job_id
            i += 1
          end
          puts "#{i} notifications retrieved and posted to #{post_uri}"
          return latest_job_id
        end
      else
        puts "No notifications found."
      end
    rescue Exception => e
      raise e
    end
  end
end