class CreatePinchRelationships < ActiveRecord::Migration
  def change
    create_table :pinch_relationships do |t|
      t.integer :user_id, :goal_id

      t.timestamps
    end
  end
end
