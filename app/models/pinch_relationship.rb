class PinchRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  after_create :create_pinch_notification

  # TODO: Move somewhere else - this seems dirty. Should this model really know about another that it doesn't directly interact with?
  def create_pinch_notification
    PinchNotification.create(pincher: self.user, goal: self.goal, goal_creator: self.goal.creator)
  end
end