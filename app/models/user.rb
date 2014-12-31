class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :goals
  has_many :learning_resources
  has_many :in_requests, foreign_key: 'recipient_id', class_name: 'ContributionRequest'
  has_many :out_requests, foreign_key: 'sender_id', class_name: 'ContributionRequest'

  has_many :contribution_permissions
  has_many :contributing_goals, through: :contribution_permissions, source: :goal

  has_many :pinch_relationships
  has_many :pinches, through: :pinch_relationships, source: :goal

  validates :password, length: {minimum: 8}, on: :create
  validates :username, length: {minimum: 3, maximum: 18}, uniqueness: true
  validates :email, presence: true, format: { with: /\A[\w\d]+[@][a-z]+.(com|co.uk)\z/ }, on: :create
  validates :tagline, length: {maximum: 35}

  def admin?
    self.role == 'admin' if !self.role.blank?
  end

  def open_in_requests
    self.in_requests.where(accepted: nil)
  end

  def open_out_requests
    self.out_requests.where(accepted: nil)
  end

  def closed_out_requests
    self.out_requests.where.not(accepted: nil)
  end
end