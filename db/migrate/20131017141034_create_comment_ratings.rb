class CreateCommentRatings < ActiveRecord::Migration
  def change
    create_table :comment_ratings do |t|
      t.integer  :cr_friendliness
      t.integer  :cr_price_of_quality
      t.integer  :cr_timeliness
      t.integer  :cr_overall
      t.integer  :comment_id,  :default => 0, :null => false, :references => [:comments, :id]
      t.integer  :user_id,  :default => 0, :null => false, :references => [:users, :id]
      
      t.timestamps
    end
  end
end
