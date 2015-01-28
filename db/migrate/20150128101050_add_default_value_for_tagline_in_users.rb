class AddDefaultValueForTaglineInUsers < ActiveRecord::Migration
  def change
    change_column :users, :tagline, :string, default: 'here to learn...'
  end
end
