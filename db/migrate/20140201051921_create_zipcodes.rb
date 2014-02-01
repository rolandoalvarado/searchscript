class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.integer  :z_zip_code
      t.string   :z_address
      t.timestamps       
    end
  end
end
