# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    new_user = User.new(registration_params)

    if new_user.save
      render json: { message: "Sign up successfully." }, status: :accepted
    else
      render json: { message: "Sign up failed." }, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :nickname, :phone_number, :birthday)
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: {
      message: "Signed up successfully.",
      user: current_user,
    }, status: :ok
  end

  def register_failed
    render json: { message: "Something went wrong." }, status: :unprocessable_entity
  end
end
