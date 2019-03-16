class CreateInstagramUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :instagram_users do |t|
      t.string :username

      t.timestamps
    end
  end
end
