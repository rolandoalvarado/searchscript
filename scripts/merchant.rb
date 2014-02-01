require_relative 'connection'

class Merchant < ActiveRecord::Base
  belongs_to :user
  belongs_to :merchant
end
