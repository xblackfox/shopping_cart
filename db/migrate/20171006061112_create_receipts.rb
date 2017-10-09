class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
    	t.references :user, foreign_key: true
       	t.float :totalcost
    end
  end
end
