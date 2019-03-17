class AddUserInstagramUserRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :instagram_users, :user, index: true
    add_foreign_key :instagram_users, :users
  end
end
