class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :password, length: {minimum: 8}, on: :create
end