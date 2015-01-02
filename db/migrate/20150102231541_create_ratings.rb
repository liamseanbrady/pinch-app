class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :stars, :user_id, :rateable_id
      t.string :rateable_type

      t.timestamps
    end
  end
end
