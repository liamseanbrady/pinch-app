class PinchNotification < ActiveRecord::Base
  belongs_to :goal_creator, class_name: 'User'
  belongs_to :pincher, class_name: 'User'
  belongs_to :goal

  scope :read, -> { where.not viewed_at: nil }
  scope :unread, -> { where viewed_at: nil }
end