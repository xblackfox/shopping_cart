require "rails_helper"
require "shoulda/matchers"

RSpec.describe CartedProduct, :type => :model do

	describe 'validations' do
		it { should belong_to(:user) }
		it { should belong_to(:product) }			
    end
end