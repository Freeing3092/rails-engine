class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all).serializable_hash.to_json
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serializable_hash.to_json
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: :created
  end

  # Need to return 404 for invalid merchant_id
  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item).serializable_hash.to_json
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
