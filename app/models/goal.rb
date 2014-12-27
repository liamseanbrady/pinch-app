class Goal < ActiveRecord::Base
  validates :title, length: {minimum: 6}
  validates :description, length: {minimum: 15, maximum: 100}
end