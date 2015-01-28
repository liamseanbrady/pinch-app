class ContributionRequestsController < ApplicationController
  before_action :set_goal, except: [:accept, :reject, :mark_as_read]
  before_action :set_contribution_request, only: [:destroy, :accept, :reject, :mark_as_read]
  before_action :require_user
  before_action :disallow_goal_creator, only: [:create, :destroy]

  def create
    if !@goal.pincher?(current_user)
      flash[:error] = 'You must pinch this goal first in order to contribute'
      redirect_to :back and return
    end

    if !@goal.public?
      flash[:error] = "You're not allowed to contribute to a private goal"
      redirect_to :back and return
    end

    request = ContributionRequest.create(sender: current_user, recipient: @goal.creator, goal: @goal)

    if request.valid?
      flash[:notice] = 'Your request was sent'
    else
      flash[:error] = 'There was a problem sending your request. Try again.'
    end

    redirect_to :back
  end

  def destroy
    if @request.delete
      flash[:notice] = 'The notification was deleted'
    else
      flash[:error] = 'The notification was not deleted'
    end

    redirect_to :back
  end

  def accept
    # flash[:notice] = 'You accepted the request'
    @request.mark_as_accepted
    # TODO: move this somewhere more appropriate
    ContributionPermission.create(user: @request.sender, goal: @request.goal)
    @request.mark_as_unread

    redirect_to :back
  end

  def reject
    # flash[:notice] = 'You rejected the request'
    @request.mark_as_rejected
    @request.mark_as_unread

    redirect_to :back
  end

  def mark_as_read
    if @request.read?
      flash[:error] = "You can only mark a request as read if it's currently unread..."
      redirect_to :back and return
    end

    @request.mark_as_read
    flash[:notice] = 'You archived the request'
    redirect_to :back
  end

  private

  def set_goal
    @goal = Goal.find_by(slug: params[:goal_id])
  end

  def set_contribution_request
    @request = ContributionRequest.find(params[:id])
  end

  def disallow_goal_creator
    if current_user == @goal.creator
      flash[:error] = "You can't request to contribute on your own goal"
      redirect_to root_path
    end
  end
end