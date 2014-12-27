class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :email, :password_digest, :tagline

      t.timestamps
    end
  end
end
