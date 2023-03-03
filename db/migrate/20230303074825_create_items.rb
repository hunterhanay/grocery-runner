class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :amountType
      t.decimal :amount
      t.decimal :price
      t.string :groceryType

      t.timestamps
    end
  end
end
