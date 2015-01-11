class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :dashboard]
  before_action :require_user, only: [:edit, :update, :show, :dashboard, :notifications]
  before_action :require_same_user, only: [:edit, :update, :dashboard]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'You registered successfully'
      session[:user_id] = @user.id
      redirect_to goals_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'You successfully updated your profile'
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show; end

  def dashboard; end

  def notifications; end

  private

  def user_params
    params.require(:user).permit(:username, :email, :tagline, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = 'You can only edit your own profile' 
      redirect_to root_path
    end
  end
end