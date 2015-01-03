class ChangeColumnsInLikesTable < ActiveRecord::Migration
  def change
    remove_column :likes, :stars
    rename_column :likes, :rateable_id, :likeable_id
    rename_column :likes, :rateable_type, :likeable_type
  end
end
