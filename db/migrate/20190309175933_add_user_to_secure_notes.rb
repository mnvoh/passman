class AddUserToSecureNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :secure_notes, :user, foreign_key: true
  end
end
