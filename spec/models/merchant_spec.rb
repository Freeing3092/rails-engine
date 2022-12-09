require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  before :each do
    @first_merchant = create(:merchant, name: "Tom's Toys")
    @last_merchant = create(:merchant, name: "Toys R Us")
  end

  describe 'class methods' do
    describe 'name_search' do
      it 'returns the first case insensitive alphabetical result with the
      query included in the name' do
        expect(Merchant.name_search('Toys')).to eq(@first_merchant)
      end
    end
  end
end
