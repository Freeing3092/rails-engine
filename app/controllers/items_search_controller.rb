class ItemsSearchController < ApplicationController
  def index
    if params[:name].present?
      items = Item.name_search(params[:name])
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif params[:min_price].present?
      items = Item.min_price_search(params[:min_price].to_f)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    end
  end
end