class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :goals
  has_many :public_goals, -> { where visibility: 'public' }, class_name: 'Goal'
  has_many :learning_resources
  has_many :likes
  has_many :in_requests, foreign_key: 'recipient_id', class_name: 'ContributionRequest'
  has_many :out_requests, foreign_key: 'sender_id', class_name: 'ContributionRequest'

  has_many :contribution_permissions
  has_many :contributing_goals, through: :contribution_permissions, source: :goal

  has_many :pinch_relationships
  has_many :pinches, through: :pinch_relationships, source: :goal

  has_many :notifications_of_goal_being_pinched, foreign_key: 'goal_creator_id', class_name: 'PinchNotification'
  has_many :pinch_notifications, foreign_key: 'pincher_id'

  validates :password, length: {minimum: 8}, on: :create
  validates :username, length: {minimum: 3, maximum: 18}, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /\A[\w\d]+[@][a-z]+.(com|co.uk)\z/ }, on: :create
  validates :tagline, length: {maximum: 35}

  def admin?
    self.role == 'admin' if !self.role.blank?
  end

  # TODO: Should these be made into associations, like has_many public_goals  ?

  def open_in_requests
    self.in_requests.where(accepted: nil)
  end

  def fresh_open_in_requests
    self.open_in_requests.where(viewed_at: nil)
  end

  def read_open_in_requests
    self.open_in_requests.where.not(viewed_at: nil)
  end

  def open_out_requests
    self.out_requests.where(accepted: nil)
  end

  def closed_out_requests
    self.out_requests.where.not(accepted: nil)
  end

  def fresh_closed_out_requests
    self.closed_out_requests.where(viewed_at: nil)
  end

  def requests_activity_count
    self.fresh_open_in_requests.count + self.fresh_closed_out_requests.count
  end

  def notification_count
    self.requests_activity_count + self.pinched_notifications.count
  end

  def read_request_count
    self.in_requests.where.not(viewed_at: nil).count
  end

  def new_notification_count
    self.requests_activity_count + self.notifications_of_goal_being_pinched.where(viewed_at: nil).count
  end
end

