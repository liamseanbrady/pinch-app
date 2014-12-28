class AddCategoryIdColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :category_id, :integer
  end
end
