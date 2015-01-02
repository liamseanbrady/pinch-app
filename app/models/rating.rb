class Rating < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :rateable, polymorphic: true

  validates :stars, inclusion: { in: 0..5 }
  validates_uniqueness_of :creator, scope: [:rateable_id, :rateable_type]
end