require 'yaml'
require 'fileutils'

class SessionController < ApplicationController
  #layout 'logged_out'

  # Initialized Config:Settings
  MAILER_DIR = File.expand_path(File.dirname __FILE__ )
  Settings = YAML.load(File.read File.join(MAILER_DIR, '../../config/settings.yml'))['settings']

  # GET /login
  def new
    if params[:redirect_to] && !params[:redirect_to].match(/logout/)
      session[:redirect_to] = params[:redirect_to]
    end
  end
  
  # GET /session
  def create
    if request.post?
		  user = User.authenticate(params[:username], params[:password])
		  
		  if user.update_attributes(:u_last_login_on => Date.today, 
                                :u_last_login_ip => request.remote_ip)
		    session[:user_id] = user.id
		    session[:username] = user.u_username
		    session[:admin] = user.u_admin
		    @current_host = request.env["HTTP_HOST"]
		    flash[:notice] = "You have successfully login."
		    redirect_to root_path
		  else
		    msg = "Sorry, that username/password could not be found."
		    redirect_to_controller_action('session', 'new', msg)
		  end
		  
		end
  end

  def logout
    session[:user_id] = nil
 	  session[:username] = nil
 	  session[:admin] = nil
   	redirect_to_site_index "You have been logged out."
  end

end
