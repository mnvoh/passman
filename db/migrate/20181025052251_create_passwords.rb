class CreatePasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :passwords do |t|
      t.string :title
      t.string :url
      t.text :password
      t.text :description
      t.string :iv
      t.string :salt
      t.integer :password_strength

      t.timestamps
    end
  end
end
