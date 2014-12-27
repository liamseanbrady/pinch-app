class Goal < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
end