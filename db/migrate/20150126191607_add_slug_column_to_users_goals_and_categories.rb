class AddSlugColumnToUsersGoalsAndCategories < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :goals, :slug, :string
    add_column :categories, :slug, :string
  end
end
