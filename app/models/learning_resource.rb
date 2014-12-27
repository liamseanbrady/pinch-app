class LearningResource < ActiveRecord::Base
  validates :url, presence: true
  validates :summary, length: {minimum: 15}
end