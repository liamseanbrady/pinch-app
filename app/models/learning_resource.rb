class LearningResource < ActiveRecord::Base
  belongs_to :goal
  belongs_to :submitter, foreign_key: 'user_id', class_name: 'User'

  validates :url, presence: true
  validates :summary, length: {minimum: 15}
end