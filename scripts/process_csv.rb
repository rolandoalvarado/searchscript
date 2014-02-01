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
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text, :headers => false)
    
    csv.each do |row|
      zip_code = row[0].to_s
      char_count = row[0].size
      r_char_count = (char_count - 6)
      # Save Zip Codes to table.
      zip_codes = [ { :z_zip_code => zip_code[0, 5], 
                     :z_address => zip_code[6, r_char_count.to_i] 
                 } ]
      zip_code_check = ZipCode.find_by z_zip_code: zip_code[0, 5] rescue nil
      # Create Zip Code Records
      result = ZipCode.create(zip_codes) if zip_code_check.nil?
      puts "Zip Code have been added to the database!" if result      
    end # end of csv.each do |row|
  end # end of if data_deleted.
end # end of if File.exists?(csv_path)
