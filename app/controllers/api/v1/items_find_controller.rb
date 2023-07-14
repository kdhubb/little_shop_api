class Api::V1::ItemsFindController < ApplicationController
  before_action :verify_params
  
  def show
    item = Item.keyword_single(params[:name])
    if item
      render json: ItemSerializer.new(item)
    else
      render json: { data: {} }
    end
  end

  def index 

  end

  private 
  def verify_params
    if params[:name] == ""
      render json: ErrorSerializer.new("no_param").no_param_error, status: :bad_request
    end
  end
end