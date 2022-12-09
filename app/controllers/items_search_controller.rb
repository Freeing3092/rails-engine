class ItemsSearchController < ApplicationController
  def index
    return render json: {message: 'Your query could not be completed', errors: ["Price paramaters cannot be below 0"]} , status: 400 if params[:min_price].to_f < 0 || params[:max_price].to_f < 0
    return render json: {message: 'Your query could not be completed', errors: ["Only the name OR either/both of the price parameters can be queried"] }, status: 400 if invalid_query?
    
    if params[:name].present?
      items = Item.name_search(params[:name])
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif price_query?
      items = Item.price_search(params[:min_price].to_f, params[:max_price].nil? ? nil : params[:max_price].to_f)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    end
  end
  
  def invalid_query?
    true if params[:name].present? && price_query?
  end
  
  def price_query?
    params[:min_price].present? || params[:max_price].present?
  end
end