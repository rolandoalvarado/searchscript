class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :u_username, :limit => 30
      t.string :u_hashed_password
      t.string :u_salt
      t.string :u_email
	    t.string :u_firstname
      t.string :u_lastname
      t.string :u_middlename
      t.boolean :u_newsletter, :default => false, :null => false
      t.string :u_phone_number
      t.boolean :u_admin, :default => false, :null => false
      t.boolean :u_status, :default => true, :null => false
      t.string :u_last_login_on
      t.string :u_last_login_ip
      
      t.timestamps
    end
  end
end
