class Goal < ActiveRecord::Base
  include Chronologicable
  include Sluggable

  ONE_FOR_GOAL_OWNER = 1

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
  scope :popular, -> { order 'created_at desc'}

  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
  validates :category, presence: true
  validates :visibility, presence: true

  validate :pinched_goal_cannot_be_made_private

  sluggable_column :title

  def pinched_goal_cannot_be_made_private
    if visibility == 'private' && !pincher_count.zero?
      errors.add(:visibility, "can't be private if your goal has been pinched.")
    end
  end

  def pincher?(usr)
    self.pinchers.include?(usr)
  end

  def contributor?(usr)
    self.contributors.include?(usr)
  end

  def dropped_by_user(usr)
    permission = self.contribution_permissions.where(user: usr).first
    permission.dependent_goal_dropped if permission

    request = self.contribution_requests.where(sender: usr).first
    request.dependent_goal_dropped if request
  end

  def contribution_request_pending?(usr)
    self.contribution_requests.where(sender: usr).any?
  end

  def pincher_count
    self.pinchers.count
  end

  def contributor_count
    self.contributors.count + goal_owner
  end

  def public?
    self.visibility == 'public'
  end

  def total_likes
    # First version nice, but not performant. Don't like calling LearningResource from here, but still cleaner.
    # self.learning_resources_empty? ? 0 : self.learning_resources.map(&:like_count).inject('+')
    LearningResource.where(goal_id: self.id).joins(:likes).count
  end
  
  def learning_resource_count
    self.learning_resources.size
  end

  def learning_resources_empty?
    self.learning_resource_count.zero?
  end

  private

  def goal_owner
    ONE_FOR_GOAL_OWNER
  end
end