#!/usr/bin/env ruby
require 'fileutils'
require 'json'
require 'csv'    
require_relative 'connection'
require_relative 'user'
require_relative 'merchant'
require_relative 'zip_code'
require File.expand_path('../../config/yelp_configuration.rb', __FILE__)

include YelpConfiguration

csv_path     = YelpConfiguration::CSV_PATH

if File.exists?(csv_path)
  puts "Found configuration file at #{ csv_path }"
  # Removed All Data in the Table.
  data_deleted = ZipCode.delete_all
    
  if data_deleted
  #---------------------------------------------------------------------------
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text, :headers => true)
    
    csv.each do |row|
      if (row['state'].to_s == 'CA' && 
         (row['county'].to_s == 'Los Angeles County' || 
         row['county'].to_s == 'Orange County'))
         # Save Zip Codes to table.
        zip_codes = [ { :z_zip_code => row['zip'].to_i, :z_address => row['primary_city'],
                      :z_type => row['type'], :z_primary_city => row['primary_city'],
                      :z_acceptable => row['acceptable_cities'], 
                      :z_unacceptable_cities => row['unacceptable_cities'],
                      :z_state => row['state'], :z_county => row['county'],
                      :z_timezone => row['timezone'], :z_area_code => row['area_codes'].to_i,
                      :z_latitude => row['latitude'].to_f, :z_longitude => row['longitude'].to_f,
                      :z_world_region => row['world_region'], :z_country => row['country'],
                      :z_decomissioned => row['decommissioned'], 
                      :z_estimated_population => row['estimated_population'].to_i,
                      :z_notes => row['notes']
                    } ]
        zip_code_check = ZipCode.find_by z_zip_code: zip_code[0, 5] rescue nil
        # Create Zip Code Records
        result = ZipCode.create(zip_codes) if zip_code_check.nil?
        puts "Zip Code have been added to the database!" if result      
      end # end of if (row['state'].to_s == 'CA' &&
    end # end of csv.each do  
  #-----------------------------------------------------------------------------
  end # end of if data_deleted.
end # end of if File.exists?(csv_path)
