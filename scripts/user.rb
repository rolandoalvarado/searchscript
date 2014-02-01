require_relative 'connection'

class User < ActiveRecord::Base
  has_one  :merchants, :foreign_key => 'user_id', :class_name => 'Merchant', 
           :dependent => :destroy  
end
