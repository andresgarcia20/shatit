# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    new_user = User.new(
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      name: params[:user][:name],
      surname: params[:user][:surname],
      nickname: params[:user][:nickname],
      phone_number: params[:user][:phone_number],
      birthday: params[:user][:birthday],
    )

    if new_user.valid?
      new_user.save
      render json: { message: "Sign up sucessfully." }, status: :accepted
    else
      render json: { message: "Sign up failed." }, status: :accepted
    end
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: {
      message: "Signed up sucessfully.",
      user: current_user,
    }, status: :ok
  end

  def register_failed
    render json: { message: "Something went wrong." }, status: :unprocessable_entity
  end
end
