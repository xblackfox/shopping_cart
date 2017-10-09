class CreateCartedProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :carted_products do |t|
    	t.references :user, foreign_key: true
    	t.references :product, foreign_key: true
    	t.integer :quantity
    end
  end
end
