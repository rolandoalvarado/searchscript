require 'singleton'
require 'rubygems'
require 'yaml'
require 'fileutils'
require 'net/http'
require 'open-uri'

module YelpConfiguration
  PATH                 = File.expand_path('../yelp.yml', __FILE__)
  CONSUMER_KEY         = :consumer_key
  CONSUMER_SECRET      = :consumer_secret
  TOKEN                = :token
  TOKEN_SECRET         = :token_secret
  API_HOST             = :api_host
  RESULT_LIMIT         = :result_limit
  SEARCH_TERM          = :search_term
  API_VERSION          = :api_version
  SPECIFIC_LOCATION    = :specific_location
  LOCATION_UNAVAILABLE = :location_unavailable
  CSV_PATH             = File.expand_path('../zip_codes.csv', __FILE__)
  
  class ConfigFile
    include Singleton
    # Add class methods here.
    
    def self.hopen(url)
      begin
        open(url)
      rescue URI::InvalidURIError
        host = url.match(".+\:\/\/([^\/]+)")[1]
        path = url.partition(host)[2] || "/"
        Net::HTTP.get host, path
      end
    end
    
  end # class ConfigFile
end # module Configuration

include YelpConfiguration
