class AddUuidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uuid, :string, null: false
    add_index :users, :uuid
  end
end
