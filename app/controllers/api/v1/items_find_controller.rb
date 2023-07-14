class Api::V1::ItemsFindController < ApplicationController
  before_action :verify_params

  def show
    render json: ItemSerializer.new(Item.case_insensitive_search(params[:name]))
  end

  def index 

  end

  private 
  def verify_params
    if params[:name] == ""
      render json: ErrorSerializer.new("error").no_param_error, status: :bad_request
    end
  end
end