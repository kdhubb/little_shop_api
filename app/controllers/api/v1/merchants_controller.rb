class Api::V1::MerchantsController < ApplicationController 
  def index 
    render json: MerchantSerializer.new(Merchant.all)
    # render json: jsonapi_serialize(merchants)
  end
  
  def show 
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end