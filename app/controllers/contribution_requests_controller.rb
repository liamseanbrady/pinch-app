class ContributionRequestsController < ApplicationController
  before_action :require_user

  def create
    goal = Goal.find(params[:goal_id])
    ContributionRequest.create(sender: current_user, recipient: goal.creator, goal: goal)

    if goal.valid?
      flash[:notice] = 'Your request was sent'
    else
      flash[:error] = 'There was a problem sending your request. Try again.'
    end

    redirect_to :back
  end
end