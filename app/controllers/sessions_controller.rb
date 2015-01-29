class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username]) || User.find_by(email: params[:username].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to goals_path
    else
      flash.now[:error] = "There's something wrong with your username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end