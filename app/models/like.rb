class Like < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :likeable, polymorphic: true

  validates_uniqueness_of :creator, scope: [:likeable_id, :likeable_type]
end