require "rails_helper"
require "shoulda/matchers"

RSpec.describe Receipt, :type => :model do

	describe 'validations' do
		it { should belong_to(:user) }
		it { should have_many(:orderitems) }			
    end
end