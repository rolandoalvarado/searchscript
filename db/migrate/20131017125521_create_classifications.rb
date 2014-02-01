class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :c_make
      t.string :c_model
      t.integer :c_year, :limit => 4
      t.integer :user_id,  :default => 0, :null => false, :references => [:users, :id]
      
      t.timestamps  
    end
  end
end
