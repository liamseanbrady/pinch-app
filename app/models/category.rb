class Category < ActiveRecord::Base
  belongs_to :goal

  validates :name, presence: true
end