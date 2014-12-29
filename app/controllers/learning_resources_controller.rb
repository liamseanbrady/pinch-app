class LearningResourcesController < ApplicationController
  before_action :set_goal
  before_action :require_user, only: [:new, :create]

  def new
    @learning_resource = LearningResource.new
  end

  def create
    @learning_resource = LearningResource.new(learning_resource_params)
    @learning_resource.submitter = current_user
    @goal.learning_resources << @learning_resource

    if @learning_resource.save
      flash[:notice] = 'Your new resource was added to the goal'
      redirect_to goals_path
    else
      render :new
    end
  end

  private

  def learning_resource_params
    params.require(:learning_resource).permit(:url, :summary)
  end

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end
end