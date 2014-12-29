class CreatePinchRequests < ActiveRecord::Migration
  def change
    create_table :pinch_requests do |t|
      t.integer :requester_id, :recipient_id, :goal_id
      t.datetime :viewed_at 

      t.timestamps
    end
  end
end
