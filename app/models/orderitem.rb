class Orderitem < ApplicationRecord
	belongs_to :receipt
	belongs_to :product
end