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
      render json: {error: "No search paramater given"}, status: :bad_request
    end
  end
end