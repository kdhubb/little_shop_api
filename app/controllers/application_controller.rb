class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_response


  def error_response(error)
    render json: ErrorSerializer.new(error).not_found, status: :not_found
  end
end
