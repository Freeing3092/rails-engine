require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items)}
  end

  before :each do
    @merchants = create_list(:merchant, 2)

    @other_item = create(:item, name: 'Dr Dolittle', description: 'A doctor discovers that he can communicate with animals.', merchant: @merchants.first)
    @ring_item1 = create(:item, name: 'The Ringer', description: "A young guy's only option to erase a really bad debt is to rig the Special Olympics by posing as a contestant.", merchant: @merchants.first)
    @ring_item2 = create(:item, name: 'The Ring', description: "A journalist must investigate a mysterious videotape which seems to cause the death of anyone one week to the day after they view it.", merchant: @merchants.first)
    @ring_item3 = create(:item, name: 'Lord of The Rings', description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.", merchant: @merchants.last)
  end

  describe 'class methods' do
    describe 'name_search' do
      it 'returns records in case insensitive alphabetical order including
      the provided query' do
        expect(Item.name_search('ring')).to eq([@ring_item3, @ring_item2, @ring_item1])
      end
    end
  end
end
