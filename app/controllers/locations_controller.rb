require "rubygems"
require "json"

class LocationsController < ApplicationController
  before_filter :load_current_user
  
  def index
    #---------------------------------------------------------------------------
    # Uses Locations Table.
    #if params[:search].present?
    #  @locations = Location.near(params[:search], 50)
    #else
    #  @locations = Location.all
    #  flash[:notice] = "No mechanic found!" if @locations.nil?
    #end
    #---------------------------------------------------------------------------
    if params[:search].present?
      params[:search] = params[:search].gsub(" ", "+")
      search_query = "/#{API_VERSION}/search?term=#{DEFAULT_SEARCH_TERM}&location=#{params[:search]}&limit=#{RESULT_LIMIT}"
      search_results = YELP_ACCESS.get(search_query).body
      locations = JSON.parse(search_results)    
      #puts "locations : #{locations}"
      
      #locations.each do |l|
      #  puts "location -> #{l}"
      #end
      
      if locations['error'] && locations['error']['id'] == LOCATION_UNAVAILABLE
        redirect_to_site_index "No mechanic found in the given location!"  
      else
        latitude = locations['region']['center']['latitude']
        longitude = locations['region']['center']['longitude']
      
        @location_hash = Gmaps4rails.build_markers(locations) do |location, marker|
          marker.lat latitude
          marker.lng longitude
        end # do
      end      
    else
      @locations = Location.all
      flash[:notice] = "No mechanic found!" if @locations.nil?
      
      @location_hash = Gmaps4rails.build_markers(@locations) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
      end # do
    end # if
  end
end
