class RenameFollowersTableAndAddRelation < ActiveRecord::Migration[6.0]
  def change
    rename_table :followers, :followers_data
    add_reference :followers_data, :instagram_user, index: true
    add_foreign_key :followers_data, :instagram_users
  end
end
