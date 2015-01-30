class FeedbackController < ApplicationController
  before_action :require_user

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.sender = current_user

    if @feedback.save
      flash[:notice] = 'Your feedback was sent successfully. Thanks!'
      redirect_to dashboard_user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])

    if @feedback.destroy
      redirect_to :back
    else
      flash[:error] = 'Feedback could not be deleted.'
      redirect_to :back
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end