require_relative 'connection'

class ZipCode < ActiveRecord::Base
  has_many :merchants
end
