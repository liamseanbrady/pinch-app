class CreatePinchNotifications < ActiveRecord::Migration
  def change
    create_table :pinch_notifications do |t|
      t.integer :pincher_id, :goal_creator_id, :goal_id
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
