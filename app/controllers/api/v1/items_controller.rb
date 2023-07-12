class Api::V1::ItemsController < ApplicationController 
  before_action :verify_merchant, only: [:update, :save]
  def index 
    render json: ItemSerializer.new(Item.all)
  end
  
  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create!(item_params)), status: :created
    else 
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def update
    render json: ItemSerializer.new(Item.update!(params[:id], item_params))
  end
  
  def destroy
    render json: ItemSerializer.new(Item.destroy!(item_params))
  end

  private 
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def verify_merchant
    if Merchant.exists?(item_params[:merchant_id]) || item_params[:merchant_id] == nil
      update
    else
      render json: {error: "Merchant must exist"}, status: :not_found
    end
  end
end