class GoalsController < ApplicationController
  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.creator = User.first

    if @goal.save
      flash[:notice] = 'Your goal was created'
      redirect_to goals_path 
    else
      render :new
    end
  end

  def show

  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :visibility)
  end
end