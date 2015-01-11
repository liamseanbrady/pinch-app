class ContributionRequestsController < ApplicationController
  before_action :set_goal, except: [:accept, :reject, :read]
  before_action :set_contribution_request, only: [:destroy, :accept, :reject, :read]
  before_action :require_user
  before_action :disallow_creator, except: [:accept, :reject, :read]
  before_action :require_sender_is_pincher, only: [:create]
  before_action :require_contribution_request_is_unread, only: [:read]

  def create
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
    flash[:notice] = 'You accepted the request'
    @request.mark_as_accepted
    ContributionPermission.create(user: @request.sender, goal: @request.goal)
    @request.mark_as_unread

    redirect_to :back
  end

  def reject
    flash[:notice] = 'You rejected the request'
    @request.mark_as_rejected
    @request.mark_as_unread

    redirect_to :back
  end

  def read
    @request.mark_as_read
    flash[:notice] = 'You archived the request'
    redirect_to :back
  end

  private

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_contribution_request
    @request = ContributionRequest.find(params[:id])
  end

  def disallow_creator
    if current_user == @goal.creator
      flash[:error] = "You can't pinch your own goal"
      redirect_to root_path
    end
  end

  def require_sender_is_pincher
    if !@goal.pincher?(current_user)
      flash[:error] = 'You must pinch this goal first in order to contribute'
      redirect_to :back
    end
  end

  def require_contribution_request_is_unread
    if @request.read?
      flash[:error] = "You can only mark a request as read if it's currently unread..."
      redirect_to :back
    end
  end
end