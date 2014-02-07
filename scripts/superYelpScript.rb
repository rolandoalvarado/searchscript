#!/usr/bin/env ruby
require 'yaml'
require 'rubygems'
require 'oauth'
require 'fileutils'
require 'json'
require 'retryable'
require_relative 'connection'
require_relative 'user'
require_relative 'merchant'
require_relative 'zip_code'
require File.expand_path('../../config/yelp_configuration.rb', __FILE__)

include YelpConfiguration

config_path     = YelpConfiguration::PATH

if File.exists?(config_path)
  puts "Found configuration file at #{ config_path }"
  config_file       = File.open(config_path, 'r+')
  @config           = YAML.load_file(config_file)
  consumer_key      = @config[:yelp_options][CONSUMER_KEY]
  consumer_secret   = @config[:yelp_options][CONSUMER_SECRET]
  api_host          = @config[:yelp_options][API_HOST]
  token             = @config[:yelp_options][TOKEN]
  token_secret      = @config[:yelp_options][TOKEN_SECRET]
  api_version       = @config[:yelp_options][API_VERSION]
  search_term       = @config[:yelp_options][SEARCH_TERM]
  specific_location = @config[:yelp_options][SPECIFIC_LOCATION]
  result_limit      = @config[:yelp_options][RESULT_LIMIT]
  site_url          = "http://#{@config[:yelp_options][API_HOST]}"
  hashed_password   = @config[:yelp_options][HASHED_PASSWORD]
  salt              = @config[:yelp_options][SALT]
  wait_timing       = @config[:yelp_options][WAIT_TIMING]
  repeat_timing     = @config[:yelp_options][REPEAT_TIMING]
  
  # Get All Zip Codes from Database.
  zip_codes         = ZipCode.all
  
    # Extract zip code 1 by 1.
    zip_codes.each do |zip_code|
      i_zip_code = zip_code[:z_zip_code].to_i
      puts "Search by #{search_term} in #{zip_code[:z_county]} with Zip Code : #{i_zip_code}"
      # No Search Limit
      search_query    = "/#{api_version}/search?term=#{search_term}&location=#{i_zip_code}"
         
      @config = {} unless @config
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => site_url })
      yelp_access = OAuth::AccessToken.new(consumer, token, token_secret)

      if i_zip_code.nil?
        puts "Please indicate a zip code as a search criteria."
      else
        retryable(:tries => repeat_timing, :sleep => wait_timing, :on => [ArgumentError, TimeoutError]) do
          search_results = yelp_access.get(search_query).body
          locations = JSON.parse(search_results) if search_results    
          
          if locations
            locations['businesses'].each do |business|
              if business
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
                  categories = (business['categories'].to_s).gsub(/\[|\]/, '') if business['categories']
                  merchant_records = [
                      { :m_business_name => business['name'], 
                        :m_business_phone_number => business['display_phone'], 
                        :m_business_address => address, 
                        :m_city => business['location']['city'], 
                        :m_state => business['location']['state_code'], 
                        :m_zip_code => business['location']['postal_code'], 
                        :m_status => 1, :user_id => user[0][:id],
                        :category => categories }
                    ]
                  
                  merchant = Merchant.find_by m_business_name: business['name']
                  # Create Merchants
                  Merchant.create(merchant_records) if merchant.nil?
                  puts "Merchant was created successfully!"
                else
                  puts "There's an error creating user data!" if user_check.nil?        
                  puts "User Data already exists in the database!" if user_check
                end # if user
              end # if business       
            end # locations['businesses'].each do |business|
          end # if locations
        end # retryable() do
      end # if zip_code[:z_zip_code].nil?
    end # end of zip_codes.each block.
else
  puts "No config file found!"
end # if File.exists?(config_path)
