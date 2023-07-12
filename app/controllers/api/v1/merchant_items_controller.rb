class Api::V1::MerchantItemsController < ApplicationController

  def index 
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    # render json: Merchant.find(params[:merchant_id]).errors, status: :not_found
  end
end