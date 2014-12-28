class ChangeDefaultValueOfVisibilityColumnInGoals < ActiveRecord::Migration
  def change
    change_column :goals, :visibility, :string, default_value: 'private'
  end
end
