class PinchNotificationsController < ApplicationController
  def destroy
    pinch_notification = PinchNotification.find(params[:id])

    if pinch_notification.destroy
      flash[:notice] = 'The notification was destroyed'
    else
      flash[:error] = 'The notification was not destroyed'
    end

    redirect_to :back
  end
end