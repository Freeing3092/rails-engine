class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serializable_hash.to_json
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(params[:id])).serializable_hash.to_json
    rescue ActiveRecord::RecordNotFound => exception 
      render json: {message: 'Your query could not be completed', errors: ['A merchant with the provided ID could not be found']}, status: 404
    end
  end
end