class RemoveGoalIdColumnFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :goal_id
  end
end
