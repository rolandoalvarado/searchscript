#!/usr/bin/env ruby
require 'yaml'
require 'rubygems'
require 'oauth'
require 'fileutils'
require 'json'
require_relative 'connection'
require_relative 'user'
require_relative 'merchant'
require File.expand_path('../../config/yelp_configuration.rb', __FILE__)

include YelpConfiguration

config_path     = YelpConfiguration::PATH

if File.exists?(config_path)
  puts "Found configuration file at #{ config_path }"
  config_file = File.open(config_path, 'r+')
  @config         = YAML.load_file(config_file)
  consumer_key    = @config[:yelp_options][CONSUMER_KEY]
  consumer_secret = @config[:yelp_options][CONSUMER_SECRET]
  api_host        = @config[:yelp_options][API_HOST]
  token           = @config[:yelp_options][TOKEN]
  token_secret    = @config[:yelp_options][TOKEN_SECRET]
  api_version     = @config[:yelp_options][API_VERSION]
  search_term     = @config[:yelp_options][SEARCH_TERM]
  result_limit    = @config[:yelp_options][RESULT_LIMIT]
  site_url        = "http://#{@config[:yelp_options][API_HOST]}"
  search_query    = "/#{api_version}/search?term=#{search_term}&location=#{ARGV[0]}&limit=#{result_limit}"
  hashed_password = "209b6555e2631734733d334277921c70260ac074" # password -> temporary
  salt            = "511550000.522232044941689"
     
  @config = {} unless @config
  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => site_url })
  yelp_access = OAuth::AccessToken.new(consumer, token, token_secret)

  # Show Parameter
  puts "Parameter : #{ARGV[0]}"
  
  if ARGV.length > 0
    
    search_results = yelp_access.get(search_query).body
    locations = JSON.parse(search_results)    
    
    locations['businesses'].each do |business|
      if (business['location']['postal_code'] == ARGV[0])
        address = (business['location']['address'].to_s).delete("[]").delete('"')
        username = business['id']
        user_records = [
            { :u_username => username[0..29], :u_firstname => business['id'], 
              :u_hashed_password => hashed_password, :u_salt => salt, 
              :u_newsletter => 1, :u_phone_number => business['phone'], 
              :u_admin => 0, :u_status => 1  }
          ]
        
        user_check = User.find_by u_firstname: business['id']
        # Create User Records
        user = User.create(user_records) if user_check.nil?
        
        if user
          merchant_records = [
              { :m_business_name => business['name'], 
                :m_business_phone_number => business['display_phone'], 
                :m_business_address => address, 
                :m_city => business['location']['city'], 
                :m_state => business['location']['state_code'], 
                :m_zip_code => business['location']['postal_code'], 
                :m_status => 1, :user_id => user[0][:id]  }
            ]
          
          merchant = Merchant.find_by m_business_name: business['name']
          # Create Merchants
          Merchant.create(merchant_records) if merchant.nil?
          puts "Merchant was created successfully!"
        else
          puts "There's an error creating user data!" if user_check.nil?        
          puts "User Data already exists in the database!" if user_check
        end # if user       
      end # if (business['location']['postal_code'] == ARGV[0])
    end # do loop
  else
    puts "Please indicate a zipcode as a search criteria."
  end # if ARGV.length > 0 
else
  puts "No config file found!"
end # if File.exists?(config_path)
