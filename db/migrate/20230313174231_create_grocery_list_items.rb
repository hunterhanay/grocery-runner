class CreateGroceryListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :grocery_list_items do |t|
      t.string :name
      t.text :description
      t.string :amount_type
      t.decimal :amount
      t.decimal :price
      t.string :grocery_type

      t.timestamps
    end
  end
end
