class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :only => [:index] do
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end

  def index
    query = User.all
    query = query.by_email(params[:email]) if params[:email].present?
    query = query.by_age(params[:age]) if params[:age].present?
    query = query.by_status(params[:status]) if params[:status].present?
    @users = query.page(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :nickname, :phone_number, :email, :birthday, (:role if current_user.admin?))
  end
end
