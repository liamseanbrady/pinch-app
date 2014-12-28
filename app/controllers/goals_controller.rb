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

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      flash[:notice] = 'Your goal was updated'
      redirect_to goals_path
    else
      render :edit
    end
  end

  def show

  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :visibility, :category_id)
  end
end