require 'rails_helper'

describe 'Merchants API' do
  before :each do
    merchants = create_list(:merchant, 5)
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:id]).to be_a Integer
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:attributes][:name]).to be_a String
    end

  end
end