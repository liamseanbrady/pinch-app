class ContributionRequestsController < ApplicationController
  before_action :require_user

  def create
    goal = Goal.find(params[:goal_id])
    request = ContributionRequest.create(sender: current_user, recipient: goal.creator, goal: goal)

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
    request.save
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
end