class Goal < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_one :category
  has_many :learning_resources

  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
end