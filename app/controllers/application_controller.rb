class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_response
  # before_action :verify_params

  def error_response(error)
    render json: ErrorSerializer.new(error).not_found, status: :not_found
  end

  # def verify_params
  #   if !params.exists?
  #     render json: {error: "No paramaters given"}, status: :bad_request
  #   end
  # end
end
