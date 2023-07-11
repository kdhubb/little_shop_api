class Api::V1::ItemsController < ApplicationController 
  def index 
    render json: ItemSerializer.new(Item.all)
  end
  
  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!)
  end
  
  def destroy
    
    render json: ItemSerializer.new(Item.destroy!)
  end
end