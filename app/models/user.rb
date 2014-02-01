class User < ActiveRecord::Base
  has_one  :classifications, :foreign_key => 'user_id', 
           :class_name => 'Classification', :dependent => :destroy, :autosave => true
  has_one  :merchants, :foreign_key => 'user_id', :class_name => 'Merchant', 
           :dependent => :destroy
    
  has_many :comments, :foreign_key => 'user_id', :class_name => 'Comment', 
           :dependent => :destroy  
  has_many :locations, :foreign_key => 'user_id', :class_name => 'Location', 
           :dependent => :destroy
  has_many :comment_ratings
    
  validates_presence_of   :u_username, :u_email, :on => :create
  validates_format_of 	  :u_email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
                          :message => 'must be valid', :multiline => true
  validates_format_of 	  :u_username, :with => /^([a-z0-9_]{2,16})$/i, 
                          :message => "must be 4 to 16 letters, numbers or underscores and have no spaces",
                          :multiline => true
  validates_format_of 	  :password, :with => /^([\x20-\x7E]){4,16}$/, 
                          :multiline => true,
                          :message => "must be 4 to 16 characters", 
                          :unless => :password_is_not_being_updated?
  
  validates_uniqueness_of :u_username, :u_email, :on => :create, 	
                          :message => "is already in use by another user." 
  validates_length_of 	  :u_username, :within => 5..30
  
  attr_accessor 		      :password_confirmation, :nick_name, :agree_wt_use

  validate 			            :password_non_blank, :on => :create
  validates_confirmation_of :password, :on => :create  

  accepts_nested_attributes_for :classifications, :allow_destroy => true
  accepts_nested_attributes_for :merchants, :allow_destroy => true
  
  def full_name
    [firstname, middlename, lastname].join.gsub("'", "").gsub(" ", "")
  end
  
  def self.authenticate(username, password)
    user = self.find_by u_username: username
  
    if user
   	  expected_password = encrypted_password(password, user.u_salt)
    		
      if user.u_hashed_password != expected_password
        user = nil
      end
    end
    user
  end
    
	# 'password' is a virtual attribute
	def password
		@password
	end
	  
	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		create_new_salt
		self.u_hashed_password = User.encrypted_password(self.password, self.u_salt)
	end
  
	def self.change_password(username, password)
		user = self.find_by_username(username)
		
		if user
			create_new_salt
		    self.u_hashed_password = User.encrypted_password(self.password, self.u_salt)
		end
	end
  
  def self.find_accounts
  		find(:all, :order => "username" )
  end

private # Private Methods

  def password_non_blank
		errors.add(:password, "Missing") if u_hashed_password.blank?
	end
	  
	def create_new_salt
		self.u_salt = self.object_id.to_s + rand.to_s
	end
	  
	def self.encrypted_password(password, salt)
		string_to_hash = password + "frozen" + salt
		Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def scrub_username
    self.username.downcase!
  end
 
  def flush_passwords
    @password = @password_confirmation = nil
  end
 
  def password_is_not_being_updated?
    self.id and self.password.blank?
  end
  
end

