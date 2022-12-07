class Api::V1::ItemsController < ApplicationController

  def index
    # render json: Item.all

    render json: ItemSerializer.serialize_items(Item.all)
  end
end
