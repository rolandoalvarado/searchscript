class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def load_current_user
  	@current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def redirect_to_site_index(msg)
		flash[:notice] = msg
		redirect_to :controller => "site", :action => 'index'
	end
	
	def redirect_to_controller_action(controller, action, msg)
	  flash[:notice] = msg
		redirect_to :controller => controller, :action => action
	end
	
protected
	def authorize
		unless User.find_by_id(session[:user_id])
			session[:original_uri] = request.fullpath
			redirect_to_site_index("You need to login in order to access the page.")
	  end
	end

end
