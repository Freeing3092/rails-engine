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

  def update
    begin
      merchant = Merchant.find(params['merchant_id']) if params['merchant_id'].present?
      item = Item.update(params[:id], item_params)
      render json: ItemSerializer.new(item).serializable_hash.to_json
    rescue ActiveRecord::RecordNotFound => exception 
      render json: {error: 'A merchant with the provided ID could not be found'}, status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
