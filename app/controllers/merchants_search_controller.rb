class MerchantsSearchController < ApplicationController
  def show
    merchant = Merchant.name_search(params[:name])
    if merchant.nil?
      render json: {'data' => {'id' => nil}}
    else
      render json: MerchantSerializer.new(merchant).serializable_hash.to_json
    end
  end
end