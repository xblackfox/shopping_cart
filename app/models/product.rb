class Product < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_many :carted_products
	has_many :orderitems
	# belongs_to :admin
end
