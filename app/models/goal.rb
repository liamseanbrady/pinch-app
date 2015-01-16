class Goal < ActiveRecord::Base
  ONE_FOR_GOAL_CREATOR = 1

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :category
  has_many :learning_resources
  has_many :contribution_requests

  has_many :contribution_permissions
  has_many :contributors, through: :contribution_permissions, source: :user

  has_many :pinch_relationships
  has_many :pinchers, through: :pinch_relationships, source: :user

  has_many :pinch_notifications

  scope :public_goals, -> { (where visibility: 'public') }

  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
  validates :category, presence: true
  validates :visibility, presence: true

  def pincher?(usr)
    self.pinchers.include?(usr)
  end

  def contributor?(usr)
    self.contributors.include?(usr)
  end

  def dropped_by_user(usr)
    permission = self.contribution_permissions.where(user: usr).first
    permission.dependent_goal_dropped if permission
  end

  def contribution_request_pending?(usr)
    self.contribution_requests.where(sender: usr).any?
  end

  def pincher_count
    self.pinchers.count
  end

  def contributor_count
    self.contributors.count + ONE_FOR_GOAL_CREATOR
  end

  def public?
    self.visibility == 'public'
  end

  def days_ago_added_less_than?(num)
    (Time.now.to_i - days_to_seconds(num)) < self.created_at.to_i
  end

  def days_to_seconds(num)
    num * 24 * 60 * 60
  end

  def total_likes
    self.learning_resources.any? ? self.learning_resources.map(&:like_count).inject('+') : 0
  end
end