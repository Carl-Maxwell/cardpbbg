class UsersController < ApplicationController
  before_action :require_guest, only: [:new, :create]
  before_action :require_user , only: [:show, :profile, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)

    redirect_to root_url
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user

    render :show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.update!(user_params)

    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
