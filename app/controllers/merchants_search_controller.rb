class MerchantsSearchController < ApplicationController
  def show
    merchant = Merchant.name_search(params[:name])

    render json: MerchantSerializer.new(merchant).serializable_hash.to_json
  end
end