class CreateLearningResources < ActiveRecord::Migration
  def change
    create_table :learning_resources do |t|
      t.string :url
      t.text :summary
      t.integer :goal_id, :user_id

      t.timestamps
    end
  end
end
