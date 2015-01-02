class LearningResource < ActiveRecord::Base
  belongs_to :goal
  belongs_to :submitter, foreign_key: 'user_id', class_name: 'User'
  has_many :ratings, as: :rateable

  validates :url, presence: true
  validates :summary, length: {minimum: 15}
end