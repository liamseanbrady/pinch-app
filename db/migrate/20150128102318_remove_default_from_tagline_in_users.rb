class RemoveDefaultFromTaglineInUsers < ActiveRecord::Migration
  def change
    change_column :users, :tagline, :string
  end
end
