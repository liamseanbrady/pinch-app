class LearningResource < ActiveRecord::Base
  belongs_to :goal
  belongs_to :submitter, foreign_key: 'user_id', class_name: 'User'
  has_many :likes, as: :likeable

  validates :url, presence: true
  validates :summary, length: {minimum: 15}

  def like_count
    self.likes.size
  end
end