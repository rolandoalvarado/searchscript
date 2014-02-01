class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :body
      t.integer :merchant_id,  :default => 0, :null => false, :references => [:merchants, :id]
      t.integer :comment_id,  :default => 0, :null => false, :references => [:comments, :id]
      
      t.timestamps
    end
  end
end
