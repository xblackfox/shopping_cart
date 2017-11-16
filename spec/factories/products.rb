FactoryGirl.define do
	
	factory :product do |f|
		f.item_name "Gold"
		f.price 14.8
		f.image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/GOLD.jpg')))
		f.quantity 5
	end	
end