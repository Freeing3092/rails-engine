require 'rails_helper'

describe 'Merchants API' do
  before :each do
    @merchants = create_list(:merchant, 5)
    @merch_1_items = create_list(:item, 3, merchant: @merchants.first)
    @merch_2_items = create_list(:item, 2, merchant: @merchants.last)

    @first_merchant = create(:merchant, name: 'Aardvarks r us')
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      # id should be Integer?
      expect(merchant[:id]).to be_a String
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to be_a String
    end
    
  end
  
  it 'can get one merchant by id' do
    get "/api/v1/merchants/#{@merchants.first.id}"
    
    expect(response).to be_successful
    
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to be_a String
    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to be_a String
  end

  it 'can return items for a given merchant id' do
    merchant = @merchants.first
    get api_v1_merchant_items_path(merchant.id)

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    
    items[:data].each do |item|
      expect(item[:id]).to be_a String
      expect(item[:type]).to eq('item')

      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
    end
  end

  it 'can return one merchant on search criteria' do
    get '/api/v1/merchants/find?name=aardvark'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(@first_merchant.name)
  end
end