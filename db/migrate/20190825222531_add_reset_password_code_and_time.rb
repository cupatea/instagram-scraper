class AddResetPasswordCodeAndTime < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :reset_password_code, :string
    add_column :users, :reset_password_time, :timestamp, null: false, default: -> { "CURRENT_TIMESTAMP" }
  end
end
