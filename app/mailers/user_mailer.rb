class UserMailer < ActionMailer::Base
  require 'rubygems'
  require 'yaml'
  require 'csv'

  default :from => "Frozen Proton Notification <#{Settings.notification_email}>"
  
  def welcome(user)
    @user = user
    @support_url = Settings.support_url
    @support_email = Settings.support_email
  		 
  	mail(:to => "#{user.u_email } <#{user.u_email}>", :subject => "Welcome to Frozen Proton!")	 
  end
  
  def register(user) 
    @user = user
    @support_url = Settings.support_url
    @support_email = Settings.support_email
  	
  	mail(:to => "Admin <rorroland@gmail.com>", :bcc => "Billing <roland.rose888@yahoo.com>", :subject => "User Details for #{user.u_username} at Frozen Proton. " )	 	 
  end
  
  def forgot_password
  end

end
