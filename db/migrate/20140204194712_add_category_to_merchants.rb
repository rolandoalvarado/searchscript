class AddCategoryToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :category, :string
  end
end
