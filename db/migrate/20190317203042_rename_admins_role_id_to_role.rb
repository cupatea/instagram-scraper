class RenameAdminsRoleIdToRole < ActiveRecord::Migration[6.0]
  def change
    rename_column :admins, :role_id, :role
  end
end
