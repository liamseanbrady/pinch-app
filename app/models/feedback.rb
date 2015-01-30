class Feedback < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'

  validates :content, length: { minimum: 10, maximum: 500 }
end