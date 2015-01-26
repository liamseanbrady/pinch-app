class Category < ActiveRecord::Base
  include Sluggable

  has_many :goals

  validates :name, presence: true

  sluggable_column :name
end