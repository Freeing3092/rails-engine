require 'rails_helper'

describe 'Merchants API' do
  before :each do
    @merchants = create_list(:merchant, 5)
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
end