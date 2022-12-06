class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.serialize_merchants(Merchant.all)
  end
end