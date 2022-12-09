require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items)}
  end

  before :each do
    @merchants = create_list(:merchant, 2)

    @other_item = create(:item, name: 'Dr Dolittle', description: 'A doctor discovers that he can communicate with animals.', unit_price: 100.00, merchant: @merchants.first)
    @ring_item1 = create(:item, name: 'The Ringer', description: "A young guy's only option to erase a really bad debt is to rig the Special Olympics by posing as a contestant.", unit_price: 90.00, merchant: @merchants.first)
    @ring_item2 = create(:item, name: 'The Ring', description: "A journalist must investigate a mysterious videotape which seems to cause the death of anyone one week to the day after they view it.", unit_price: 30.00, merchant: @merchants.first)
    @ring_item3 = create(:item, name: 'Lord of The Rings', description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.", unit_price: 40.00, merchant: @merchants.last)
  end

  describe 'class methods' do
    describe 'name_search' do
      it 'returns records in case insensitive alphabetical order including
      the provided query' do
        expect(Item.name_search('ring')).to eq([@ring_item3, @ring_item2, @ring_item1])
      end
    end

    describe 'price_serach' do
      it 'returns records matching the price argument(s) provided' do
        expect(Item.price_search(35.99, 99.99)).to eq([@ring_item3, @ring_item1])
      end
      
      it 'returns records matching a min_price argument' do
        expect(Item.price_search(35.99, nil)).to eq([@other_item, @ring_item3, @ring_item1])
      end
      
      it 'returns records matching a max_price argument' do
        expect(Item.price_search(nil, 50.99)).to eq([@ring_item3, @ring_item2])
      end
    end
  end
end
