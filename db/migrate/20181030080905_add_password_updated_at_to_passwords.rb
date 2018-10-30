class AddPasswordUpdatedAtToPasswords < ActiveRecord::Migration[5.2]
  def change
    add_column :passwords, :password_updated_at, :datetime
  end
end
