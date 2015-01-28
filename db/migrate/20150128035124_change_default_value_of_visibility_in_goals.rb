class ChangeDefaultValueOfVisibilityInGoals < ActiveRecord::Migration
  def change
    change_column :goals, :visibility, :string, default: 'private'
  end
end
