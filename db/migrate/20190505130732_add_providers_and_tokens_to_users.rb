class AddProvidersAndTokensToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :uuid
    rename_column :users, :uuid, :uid
    add_column :users, :provider, :string, null: false, default: 'email'
    add_column :users, :tokens, :text
    add_index :users, [:uid, :provider], unique: true
  end
end
