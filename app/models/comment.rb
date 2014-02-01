class Comment < ActiveRecord::Base
  belongs_to :user
  
  has_many :responses
  has_many :comment_ratings
end
