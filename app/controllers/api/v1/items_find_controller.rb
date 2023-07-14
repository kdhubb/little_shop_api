class Api::V1::ItemsFindController < ApplicationController
  
  def show
    require 'pry'; binding.pry
    render json: ItemSerializer.new(Item.case_insensitive_search(params[:name]))
  end

  def index 

  end
end