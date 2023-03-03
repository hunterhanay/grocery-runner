class RenameColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :groceryType, :grocery_type
    rename_column :items, :amountType, :amount_type
  end
end
