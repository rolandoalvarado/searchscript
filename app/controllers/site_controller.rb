class SiteController < ApplicationController

  before_filter :load_current_user  
  
  def index
    @locations = Location.all
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end
  end
  
  def yelp
    
  end
  
  def yelp2
    render layout: "logged_out"
  end
  
end
