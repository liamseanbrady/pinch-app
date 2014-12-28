class Goal < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_one :category
  has_many :learning_resources

  has_many :contribution_permissions
  has_many :contributors, through: :contribution_permissions, source: :user

  has_many :pinch_relationships
  has_many :pinchers, through: :pinch_relationships, source: :user

  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
end