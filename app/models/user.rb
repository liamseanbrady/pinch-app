class User < ActiveRecord::Base
  include Gravatarable
  include Sluggable

  has_secure_password validations: false

  has_many :goals
  has_many :public_goals, -> { where visibility: 'public' }, class_name: 'Goal'
  has_many :learning_resources
  has_many :likes
  has_many :liked_learning_resources, through: :likes, source: :likeable, source_type: 'LearningResource'
  has_many :incoming_contribution_requests, foreign_key: 'recipient_id', class_name: 'ContributionRequest'
  has_many :outgoing_contribution_requests, foreign_key: 'sender_id', class_name: 'ContributionRequest'

  has_many :contribution_permissions
  has_many :contributing_goals, through: :contribution_permissions, source: :goal

  has_many :pinch_relationships
  has_many :pinches, through: :pinch_relationships, source: :goal

  has_many :pinched_notifications, foreign_key: 'goal_creator_id', class_name: 'PinchNotification'
  has_many :pinching_notifications, foreign_key: 'pincher_id', class_name: 'PinchNotification'

  validates :password, length: {minimum: 8}, on: :create
  validates :username, length: {minimum: 3, maximum: 18}, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: %r{\A[a-z\d]+[@][a-z]+\.[a-z]+\z} }, uniqueness: true
  validates :tagline, length: {maximum: 35}, allow_blank: true
  validates :github_username, format: { with: %r{\A[^-][a-zA-Z1-9-]+\z} }, allow_blank: true

  gravatar_column :email
  sluggable_column :username

  # Can't set default at db level because it will show up in the registration form instead of placeholder
  # This callback still runs even when self.persisted? == true. Strange.
  before_save :default_tagline_if_tagline_empty if :new_record?


  def admin?
    self.role == 'admin' if !self.role.blank?
  end

  def github?
    !self.github_username.blank?
  end

  def default_tagline_if_tagline_empty
    self.tagline = 'Here to learn...' if self.tagline.empty?
  end

  def incoming_contribution_requests_pending
    incoming_contribution_requests.pending
  end

  def incoming_contribution_requests_pending_unread
    incoming_contribution_requests_pending.unread
  end

  def incoming_contribution_requests_pending_read
    incoming_contribution_requests_pending.read
  end

  def outgoing_contribution_requests_accepted_unread
    outgoing_contribution_requests.accepted.unread
  end

  # TODO: Needs better name
  def requests_activity_count
    incoming_contribution_requests_pending_unread.count + outgoing_contribution_requests_accepted_unread.count
  end

  def read_request_count
    incoming_contribution_requests_pending_read.count
  end

  def notification_count
    requests_activity_count + pinched_notifications.count
  end

  def new_notification_count
    requests_activity_count + pinched_notifications.unread.count
  end
end

