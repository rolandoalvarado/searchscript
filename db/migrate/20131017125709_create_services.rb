class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.boolean   :s_full_service
      t.boolean   :s_change_oil
      t.boolean   :s_tire_service
      t.boolean   :s_engine_service
      t.boolean   :s_auto_body
      t.boolean   :s_smog_check
      t.boolean   :s_high_performance
      t.boolean   :s_diesel
      t.boolean   :s_motorcyles
      t.boolean   :s_brakes
      t.boolean   :s_hybrids
      t.boolean   :s_natural_gas_vehicles
      t.integer   :merchant_id,  :default => 0, :null => false, :references => [:merchants, :id]
      
      t.timestamps
    end
  end
end
