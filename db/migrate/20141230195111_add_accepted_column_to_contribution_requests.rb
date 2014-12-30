class AddAcceptedColumnToContributionRequests < ActiveRecord::Migration
  def change
    add_column :contribution_requests, :accepted, :boolean
  end
end
