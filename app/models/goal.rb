class Goal < ActiveRecord::Base
  TWO_DAYS = 2 * 24 * 60 * 60

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

  def pincher_count
    self.pinchers.count
  end

  def contributor_count
    self.contributors.count + 1
  end

  def public?
    self.visibility == 'public'
  end

  def recently_added?
    Time.now.sec - TWO_DAYS < self.created_at.sec
  end

  def total_likes
    self.learning_resources.any? ? self.learning_resources.map(&:like_count).inject('+') : 0
  end
end