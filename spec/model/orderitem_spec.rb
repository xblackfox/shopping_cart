require "rails_helper"
require "shoulda/matchers"

RSpec.describe Orderitem, :type => :model do

	describe 'validations' do
		it { should belong_to(:receipt) }
		it { should belong_to(:product) }			
    end
end