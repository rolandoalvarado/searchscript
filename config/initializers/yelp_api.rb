require 'rubygems'
require 'oauth'
require 'yaml'
require 'fileutils'
require 'optparse'
require File.expand_path('../../../config/yelp_configuration.rb', __FILE__)

include YelpConfiguration

config_path     = YelpConfiguration::PATH

if File.exists?(config_path)
  config_file = File.open(config_path, 'r+')
  @config         = YAML.load_file(config_file)
  consumer_key    = @config[:yelp_options][CONSUMER_KEY]
  consumer_secret = @config[:yelp_options][CONSUMER_SECRET]
  api_host        = @config[:yelp_options][API_HOST]
  token           = @config[:yelp_options][TOKEN]
  token_secret    = @config[:yelp_options][TOKEN_SECRET]
  site_url        = "http://#{@config[:yelp_options][API_HOST]}"

  RESULT_LIMIT          = @config[:yelp_options][RESULT_LIMIT]
  DEFAULT_SEARCH_TERM   = @config[:yelp_options][SEARCH_TERM]
  API_VERSION           = @config[:yelp_options][API_VERSION]
  LOCATION_UNAVAILABLE  = @config[:yelp_options][LOCATION_UNAVAILABLE]

  #-----------------------------------------------------------------------------
  # Use this data for testing directly to a page.
  #YELP_CONSUMER_KEY = @authentications['consumer_key']
  #YELP_CONSUMER_SECRET = @authentications['consumer_secret']
  #YELP_TOKEN = @authentications['token']
  #YELP_TOKEN_SECRET = @authentications['token_secret']
  #YELP_API_HOST = @authentications['api_host']
  #-----------------------------------------------------------------------------

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
  YELP_ACCESS = OAuth::AccessToken.new(consumer, token, token_secret)
end
