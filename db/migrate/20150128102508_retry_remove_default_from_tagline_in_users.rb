class RetryRemoveDefaultFromTaglineInUsers < ActiveRecord::Migration
  def change
    change_column :users, :tagline, :string, default: nil
  end
end
