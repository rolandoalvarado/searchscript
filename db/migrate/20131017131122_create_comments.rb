class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id,  :default => 0, :null => false, :references => [:users, :id]
       
      t.timestamps
    end
  end
end
