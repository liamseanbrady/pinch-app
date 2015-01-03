class RenameRatingsTableToLikesTable < ActiveRecord::Migration
  def change
    rename_table :ratings, :likes
  end
end
