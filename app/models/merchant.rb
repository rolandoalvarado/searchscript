class Merchant < ActiveRecord::Base
  belongs_to :user
  
  has_one :services, :foreign_key => 'merchant_id', :class_name => 'Service', :dependent => :destroy
  has_one :vehicle_types, :foreign_key => 'merchant_id', :class_name => 'VehicleType', :dependent => :destroy
  
  has_many :responses, :foreign_key => 'merchant_id', :class_name => 'Response', :dependent => :destroy
end
