class CreateOrderitems < ActiveRecord::Migration[5.1]
  def change
    create_table :orderitems do |t|
    	t.references :product, foreign_key: true
    	t.integer :quantity
    	t.references :receipt, foreign_key: true
    end
  end
end
