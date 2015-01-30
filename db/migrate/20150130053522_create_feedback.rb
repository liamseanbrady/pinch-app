class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedback do |t|
      t.column :content, :text
      t.column :user_id, :integer

      t.timestamps
    end
  end
end
