class ContributionRequestsController < ApplicationController
  before_action :set_goal, only: [:create]
  before_action :require_user
  before_action :require_sender_as_pincher, only: [:create]

  def create
    request = ContributionRequest.create(sender: current_user, recipient: @goal.creator, goal: @goal)

    if request.valid?
      flash[:notice] = 'Your request was sent'
    else
      flash[:error] = 'There was a problem sending your request. Try again.'
    end

    redirect_to :back
  end

  def update
    request = ContributionRequest.find(params[:id])

    if params[:accept] == 'true'
      flash[:notice] = 'You accepted the request'
      request.mark_as_accepted
      ContributionPermission.create(user: request.sender, goal: request.goal)
    else
      flash[:notice] = 'You rejected the request'
      request.mark_as_rejected
    end

    request.mark_as_unread

    redirect_to :back
  end

  def destroy
    request = ContributionRequest.find(params[:id])

    if request.delete
      flash[:notice] = 'The notification was deleted'
    else
      flash[:error] = 'The notification was not deleted'
    end

    redirect_to :back
  end

  private

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def require_sender_as_pincher
    if !@goal.pincher?(current_user)
      flash[:error] = 'You must pinch this goal first in order to contribute'
      redirect_to :back
    end
  end
end