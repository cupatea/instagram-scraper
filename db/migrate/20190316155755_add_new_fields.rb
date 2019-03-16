class AddNewFields < ActiveRecord::Migration[6.0]
  def change
    add_column :instagram_users, :posts_count, :integer, default: 0
    add_column :followers_data, :new_post, :boolean, default: false
  end
end
