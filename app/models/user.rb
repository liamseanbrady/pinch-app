class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :goals

  validates :password, length: {minimum: 8}, on: :create
  validates :username, length: {minimum: 3, maximum: 18}
  validates :email, presence: true, format: { with: /\A[\w\d]+[@][a-z]+.(com|co.uk)\z/ }, on: :create
  validates :tagline, length: {maximum: 35}
end