class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :item_name
      t.float :price
      t.string :image
      t.integer :quantity

      t.timestamps
    end
  end
end
