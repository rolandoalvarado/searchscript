class CreateVehicleTypes < ActiveRecord::Migration
  def change
    create_table :vehicle_types do |t|
      t.boolean  :vt_all_types
      t.boolean  :vt_classic_cars
      t.boolean  :vt_european_care
      t.boolean  :vt_japanese_imports
      t.boolean  :vt_domestic
      t.boolean  :vt_custom
      t.boolean  :vt_other
      t.integer  :merchant_id,  :default => 0, :null => false, :references => [:merchants, :id]

      t.timestamps
    end
  end
end
