class RemoveUserIdFromInstagramUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :instagram_users, :user_id
  end
end
