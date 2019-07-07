class AddStatusToInstagramUser < ActiveRecord::Migration[6.0]
  def change
    add_column :instagram_users, :status, :integer, null: false, default: 0
  end
end
