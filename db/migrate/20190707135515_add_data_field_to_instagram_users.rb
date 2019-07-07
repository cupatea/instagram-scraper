class AddDataFieldToInstagramUsers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :instagram_users, :data, :hstore
    add_index :instagram_users, :data, using: :gin
  end
end
