class CreateSecureNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :secure_notes do |t|
      t.string :title
      t.string :iv
      t.string :salt
      t.integer :password_strength

      t.timestamps
    end
  end
end
