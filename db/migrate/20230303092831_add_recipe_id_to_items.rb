class AddRecipeIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :recipe, null: false, foreign_key: true
  end
end
