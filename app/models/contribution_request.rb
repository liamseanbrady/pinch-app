class ContributionRequest < ActiveRecord::Base
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'
  belongs_to :goal

  scope :pending, -> { where accepted: nil }
  scope :accepted, -> { where.not accepted: nil}
  scope :unread, -> { where viewed_at: nil }
  scope :read, -> { where.not viewed_at: nil }

  def dependent_goal_dropped
    self.delete
  end

  def mark_as_accepted
    self.update(accepted: true)
  end

  def mark_as_rejected
    self.update(accepted: false)
  end

  def mark_as_unread
    self.update(viewed_at: nil)
  end

  def mark_as_read
    self.update(viewed_at: Time.now)
  end

  def read?
    !self.viewed_at.nil?
  end
end