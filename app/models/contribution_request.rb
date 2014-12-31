class ContributionRequest < ActiveRecord::Base
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'
  belongs_to :goal

  def mark_as_accepted
    self.accepted = true
  end

  def mark_as_rejected
    self.accepted = false
  end
end