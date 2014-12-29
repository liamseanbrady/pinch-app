class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'You registered successfully'
      redirect_to goals_path
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :tagline, :password)
  end
end