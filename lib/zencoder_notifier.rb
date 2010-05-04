require 'rubygems'
require 'httparty'
require 'json'

module ZencoderNotifier
  NOTIFIER_VERSION = [0,1] unless defined?(NOTIFIER_VERSION)
  
  def self.version
    NOTIFIER_VERSION.join(".")
  end
  
  def self.request(options={})
    api_key = options[:api_key]
    post_uri = options[:url] ? options[:url] : "http://localhost:3000"
    per_page = options[:count] ? options[:count] : 50
    page = options[:page] ? options[:page] : 1
    
    begin
      response = HTTParty.get("http://localhost:3000/api/notifications.json?api_key=#{api_key}&per_page=#{per_page}&page=#{page}")
      if response.is_a?(Array)
        response.each do |job|
          job = JSON.parse(job)
          HTTParty.post(post_uri, job)
        end
        puts "#{response.size} notifications retrieved and posted to #{post_uri}"
      else
        puts JSON.parse(response.body)["errors"]
      end
    rescue Exception => e
      raise e
    end
  end
end