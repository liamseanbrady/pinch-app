class CreateContributionPermissions < ActiveRecord::Migration
  def change
    create_table :contribution_permissions do |t|
      t.integer :user_id, :goal_id

      t.timestamps
    end
  end
end
