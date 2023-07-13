class Api::V1::ItemsFindController < ApplicationController
  
  def show
    render json: ItemSerializer.new(Item.case_insensitive_search(params[:name]))
  end

  def index 

  end
end