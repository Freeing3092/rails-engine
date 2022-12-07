require 'rails_helper'

describe 'Items API' do

  before :each do
    merchants = create_list(:merchant, 2)
    merch_1_items = create_list(:item, 3, merchant: merchants.first)
    merch_2_items = create_list(:item, 2, merchant: merchants.last)
  end

  it 'sends a list of items' do
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item[:id]).to be_a String
      expect(item[:type]).to eq('item')

      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end
end