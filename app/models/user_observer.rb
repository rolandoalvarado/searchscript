class UserObserver < ActiveRecord::Observer 
	def after_create(user) 
		UserMailer.register(user).deliver  
	end 
end 
