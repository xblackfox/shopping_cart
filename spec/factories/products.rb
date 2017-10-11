FactoryGirl.define do
	
	factory :product do |f|
		f.item_name "Gold"
		f.price 14.8
		# f.image
		f.quantity 5
	end	
end