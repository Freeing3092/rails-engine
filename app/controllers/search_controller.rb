class SearchController < ApplicationController
  def index
    items = Item.name_search(params[:name])
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end
end