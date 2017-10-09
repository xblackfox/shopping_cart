class Receipt < ApplicationRecord
	belongs_to :user, dependent: :destroy 
	has_many :orderitems
end