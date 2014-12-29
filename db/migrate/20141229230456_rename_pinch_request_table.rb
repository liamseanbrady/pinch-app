class RenamePinchRequestTable < ActiveRecord::Migration
  def change
    rename_table :pinch_requests, :contribution_requests
  end
end
