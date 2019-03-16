class AddUserToPasswords < ActiveRecord::Migration[5.2]
  def change
    add_reference :passwords, :user, foreign_key: true
  end
end
