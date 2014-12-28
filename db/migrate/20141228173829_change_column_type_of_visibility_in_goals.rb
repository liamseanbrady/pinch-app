class ChangeColumnTypeOfVisibilityInGoals < ActiveRecord::Migration
  def change
    change_column :goals, :visibility, :string
  end
end
