class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :m_business_name
      t.string :m_contact_name
      t.string :m_business_email
      t.string :m_business_phone_number
      t.string :m_business_address
      t.string :m_city
      t.string :m_state
      t.string :m_zip_code
      t.boolean :m_status, :default => true, :null => false
      t.integer :user_id,  :default => 0, :null => false, :references => [:users, :id]
      
      t.timestamps
    end
  end
end
