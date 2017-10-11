require "rails_helper"
require "shoulda/matchers"

RSpec.describe User, :type => :model do

	describe 'validations' do
		it { should have_many(:carted_products) }
		it { should have_many(:receipts) }			
    end
end