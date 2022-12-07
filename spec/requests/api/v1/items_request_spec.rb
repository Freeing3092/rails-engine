require 'rails_helper'

describe 'Items API' do

  before :each do
    @merchants = create_list(:merchant, 2)
    @merch_1_items = create_list(:item, 3, merchant: @merchants.first)
    @merch_2_items = create_list(:item, 2, merchant: @merchants.last)
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
  
  it 'can get a single item by id' do
    item = @merch_1_items.first
    get "/api/v1/items/#{item.id}"
    
    expect(response).to be_successful
    
    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json[:data][:attributes][:name]).to be_a String
    expect(item_json[:data][:attributes][:description]).to be_a String
    expect(item_json[:data][:attributes][:unit_price]).to be_a Float
    expect(item_json[:data][:attributes][:merchant_id]).to be_a Integer
  end

  it 'can create a new item' do
    new_item_params = {name: 'Gizmo', description: 'For your everyday gizmo needs!', unit_price: 10000, merchant_id: @merchants.first.id}
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: new_item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(new_item_params[:name])
    expect(created_item.description).to eq(new_item_params[:description])
    expect(created_item.unit_price).to eq(new_item_params[:unit_price])
    expect(created_item.merchant_id).to eq(new_item_params[:merchant_id])
  end
  
  it 'can edit an item' do
    item_to_edit = @merch_1_items.last
    new_item_params = {name: 'Gizmo', description: 'For your everyday gizmo needs!', unit_price: 10000, merchant_id: @merchants.first.id}
    headers = {"CONTENT_TYPE" => "application/json"}
    
    patch "/api/v1/items/#{item_to_edit.id}", headers: headers, params: JSON.generate(new_item_params)
    
    updated_item = Item.find(item_to_edit.id)

    expect(response).to be_successful

    expect(updated_item.name).to eq(new_item_params[:name])
    expect(updated_item.description).to eq(new_item_params[:description])
    expect(updated_item.unit_price).to eq(new_item_params[:unit_price])
    expect(updated_item.merchant_id).to eq(new_item_params[:merchant_id])
  end

  it 'can delete an item' do
    num_items = Item.count
    item_to_delete = @merch_2_items.first
    headers = {"CONTENT_TYPE" => "application/json"}

    delete "/api/v1/items/#{item_to_delete.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(num_items - 1)
    expect{Item.find(item_to_delete.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end