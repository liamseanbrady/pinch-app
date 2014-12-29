class GoalsController < ApplicationController
  before_action :set_goal, only: [:edit, :update, :show]
  before_action :require_user, except: [:index]
  before_action :require_creator, only: [:edit, :update]
  before_action :disallow_creator, only: [:pinch]

  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.creator = current_user

    if @goal.save
      flash[:notice] = 'Your goal was created'
      redirect_to goals_path 
    else
      render :new
    end
  end

  def edit; end

  def update
    if @goal.update(goal_params)
      flash[:notice] = 'Your goal was updated'
      redirect_to goals_path
    else
      render :edit
    end
  end

  def show; end

  def pinch
    goal = Goal.find(params[:id])
    goal.pinchers << current_user

    redirect_to :back
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :visibility, :category_id)
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def require_creator
    if current_user != @goal.creator
      flash[:error] = 'You can only edit your own goals'
      redirect_to root_path
    end
  end

  def disallow_creator
    if current_user == @goal.creator
      flash[:error] = "You can't pinch your own goal"
      redirect_to root_path
    end
  end
end

