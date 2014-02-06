class AddFieldsToZipCodes < ActiveRecord::Migration
  def change
    add_column :zip_codes, :z_type, :string
    add_column :zip_codes, :z_primary_city, :string
    add_column :zip_codes, :z_acceptable, :string
    add_column :zip_codes, :z_unacceptable_cities, :string
    add_column :zip_codes, :z_state, :string
    add_column :zip_codes, :z_county, :string
    add_column :zip_codes, :z_timezone, :string
    add_column :zip_codes, :z_area_code, :integer
    add_column :zip_codes, :z_latitude, :float
    add_column :zip_codes, :z_longitude, :float
    add_column :zip_codes, :z_world_region, :string
    add_column :zip_codes, :z_country, :string
    add_column :zip_codes, :z_decomissioned, :integer
    add_column :zip_codes, :z_estimated_population, :integer
    add_column :zip_codes, :z_notes, :string
  end
end
