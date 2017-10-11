require "rails_helper"
require "shoulda/matchers"

RSpec.describe Product, :type => :model do

	subject{ build(:product)}

	describe 'validations' do
		it { expect(subject).to validate_presence_of(:item_name)}
		it { expect(subject).to validate_presence_of(:price)}
		it { expect(subject).to validate_presence_of(:quantity)}
		it { expect(subject).to validate_presence_of(:image)}

		it { should validate_presence_of(:item_name) }
		it { should validate_presence_of(:price) }
		it { should validate_presence_of(:image) }
		it { should validate_presence_of(:quantity) }
		it { should have_many(:carted_products) }
		it { should have_many(:orderitems) }			
    end
end
