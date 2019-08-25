class RemoveEmailFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :provider, :string, default: 'username'
  end
end
