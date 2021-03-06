class User < ActiveRecord::Base
  include Gravatarable
  include Sluggable

  DEFAULT_TAGLINE = 'Here to learn...'

  has_secure_password validations: false

  has_many :goals
  has_many :public_goals, -> { where visibility: 'public' }, class_name: 'Goal'
  has_many :learning_resources
  has_many :likes
  has_many :liked_learning_resources, through: :likes, source: :likeable, source_type: 'LearningResource'
  has_many :incoming_contribution_requests, foreign_key: 'recipient_id', class_name: 'ContributionRequest'
  has_many :outgoing_contribution_requests, foreign_key: 'sender_id', class_name: 'ContributionRequest'

  has_many :contribution_permissions
  has_many :goals_contributing_to, through: :contribution_permissions, source: :goal

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


  def default_tagline_if_tagline_empty
    self.tagline = DEFAULT_TAGLINE if self.tagline.empty?
  end

  def admin?
    self.role == 'admin' if self.role.present?
  end

  def github_username_provided?
    self.github_username.present?
  end

  def incoming_contribution_requests_pending_unread
    incoming_contribution_requests.pending.unread
  end

  def incoming_contribution_requests_pending_read
    incoming_contribution_requests.pending.read
  end

  def outgoing_contribution_requests_accepted_unread
    outgoing_contribution_requests.accepted.unread
  end

  def read_requests_count
    incoming_contribution_requests_pending_read.count
  end

  def unread_notification_count
    total_unread_requests_count + pinched_notifications.unread.count
  end

  private

  def total_unread_requests_count
    incoming_contribution_requests_pending_unread.count + outgoing_contribution_requests_accepted_unread.count
  end
end

