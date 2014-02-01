class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.integer  :z_zip_code
      t.string   :z_address
      t.string   :z_population
      t.timestamps       
    end
  end
end
