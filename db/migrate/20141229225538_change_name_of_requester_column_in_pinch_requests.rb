class ChangeNameOfRequesterColumnInPinchRequests < ActiveRecord::Migration
  def change
    rename_column :pinch_requests, :requester_id, :sender_id
  end
end
