class UsersController < ApplicationController
  before_action :require_guest, only: [:new, :create]
  before_action :require_user , only: [:show, :profile, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
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

    if @user.update(user_params)
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end


  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
