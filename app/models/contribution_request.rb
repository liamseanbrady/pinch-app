class ContributionRequest < ActiveRecord::Base
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'
  belongs_to :goal

  def mark_as_accepted
    self.update(accepted: true)
  end

  def mark_as_rejected
    self.update(accepted: false)
  end

  def mark_as_unread
    self.update(viewed_at: nil)
  end
end