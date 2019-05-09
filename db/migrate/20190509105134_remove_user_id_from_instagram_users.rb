class RemoveUserIdFromInstagramUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :instagram_users, :user_id
  end
end
