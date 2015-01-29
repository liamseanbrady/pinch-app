class LearningResourcesController < ApplicationController
  before_action :set_learning_resource, only: [:like]
  before_action :set_goal, only: [:new, :create, :like]
  before_action :require_user, only: [:new, :create, :like]
  before_action :require_goal_creator_or_contributor, only: [:new, :create]
  before_action :disallow_resource_submitter, only: [:like]
  before_action :require_pincher_or_creator, only: [:like]

  def new
    @learning_resource = LearningResource.new
  end

  def create
    @learning_resource = LearningResource.new(learning_resource_params)
    @learning_resource.submitter = current_user
    @goal.learning_resources << @learning_resource

    if @learning_resource.save
      flash[:notice] = 'Your new resource was added to the goal'
      redirect_to goal_path(@goal)
    else
      render :new
    end
  end

  def like
    bidning.pry
    @like = Like.create(creator: current_user, likeable: @learning_resource)

    respond_to do |format|
      format.html do
        if @like.valid?
          flash[:notice] = 'You liked a resource!'
        else
          flash[:error] = @learning_resource.liked_by?(current_user) ? 'You can only like a resource once' : 'There was an error liking the resource. Try again.'
        end

        redirect_to :back
      end
      format.js
    end
  end

  private

  def learning_resource_params
    params.require(:learning_resource).permit(:url, :summary)
  end

  def set_learning_resource
    @learning_resource = LearningResource.find(params[:id])
  end

  def set_goal
    @goal = Goal.find_by(slug: params[:goal_id])
  end

  def require_goal_creator_or_contributor
    if current_user != @goal.creator && !@goal.contributor?(current_user)
      flash[:error] = "You don't have permission to do that"
      redirect_to root_path
    end
  end

  def disallow_resource_submitter
    if current_user == @learning_resource.submitter
      respond_to do |format|
        format.html do
          flash.now[:error] = "You can't like a resource you submitted"
          redirect_to :back
        end
        format.js do
          @message = "You cannot like a resource you submitted"
          render :like
          return
        end
      end
    end
  end

  def require_pincher_or_creator
    if !@goal.pincher?(current_user) && current_user != @goal.creator
      respond_to do |format|
        format.html do
          flash.now[:error] = 'You have to pinch the goal in order to like this resource!'
          redirect_to :back
        end
        format.js do
          @message = 'You have to pinch the goal in order to like this resource!'
          render :like
          return
        end
      end
    end
  end
end