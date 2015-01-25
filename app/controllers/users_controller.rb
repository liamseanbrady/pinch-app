class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :dashboard]
  before_action :require_user, only: [:edit, :update, :show, :dashboard, :notifications]
  before_action :require_user_is_set_user, only: [:edit, :update, :dashboard]
  before_action :redirect_logged_in_user, only: [:new, :create]

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

  def require_user_is_set_user
    if current_user != @user
      flash[:error] = 'You are not authorized to view this page'
      redirect_to root_path
    end
  end

  def redirect_logged_in_user
    if logged_in?
      redirect_to dashboard_user_path(current_user)
    end
  end
end