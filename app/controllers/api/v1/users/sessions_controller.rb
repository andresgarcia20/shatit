# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      @current_user = user
      render json: {
        message: "You are logged in.",
        user: current_user,
      }, status: :ok
    else
      render json: { message: "Error, Unauthorized" }, status: :unauthorized
    end
  end

  private

  def respond_with(_resource, _opts = {})
    render json: {
      message: "You are logged in.",
      user: current_user,
    }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened." }, status: :unauthorized
  end
end
