class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serializable_hash.to_json
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])).serializable_hash.to_json
  end
end