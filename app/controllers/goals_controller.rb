class GoalsController < ApplicationController
  before_action :set_goal, only: [:edit, :update, :show, :pinch, :drop]
  before_action :require_user, except: [:index]
  before_action :require_creator, only: [:edit, :update]
  before_action :disallow_creator, only: [:pinch, :drop]

  def index
    @goals = Goal.public_goals
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
    if !@goal.pincher?(current_user) && @goal.public?
      flash[:notice] = 'You successfully pinched a goal'
      @goal.pinchers << current_user
      PinchNotification.create(pincher: current_user, goal: @goal, goal_creator: @goal.creator)
    else
      flash[:error] = "There was an error - goal couldn't be pinched!"
    end

    redirect_to :back
  end

  def drop
    if @goal.pincher?(current_user)
      flash[:notice] = 'You dropped a goal'
      @goal.dropped_by_user(current_user) if @goal.pinchers.delete(current_user)
    else
      flash[:error] = "There was an error dropping the goal"
    end

    redirect_to :back
  end

  def search
    @search_term = params[:search_term]

    if !@search_term.empty?
      @goals = Goal.public_goals.where('LOWER(title) LIKE ?', "%#{@search_term}%")
    else
      flash[:error] = 'Your search term was empty...'
      redirect_to :back
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :visibility, :category_id)
  end

  def set_goal
    @goal = Goal.find_by(slug: params[:id])
  end

  def require_creator
    if current_user != @goal.creator
      flash[:error] = 'You can only edit your own goals'
      redirect_to root_path
    end
  end

  def disallow_creator
    if current_user == @goal.creator
      flash[:error] = "You can't do that your own goal"
      redirect_to root_path
    end
  end
end

