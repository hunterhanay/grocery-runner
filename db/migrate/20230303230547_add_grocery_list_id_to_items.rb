class AddGroceryListIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :grocery_list, null: false, foreign_key: true
  end
end
