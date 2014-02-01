class AddUserToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :user_id, :integer, :default => 0, :null => false, 
                       :references => [:users, :id]
  end
end
