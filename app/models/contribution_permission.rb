class ContributionPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  def dependent_goal_dropped
    self.destroy
  end
end