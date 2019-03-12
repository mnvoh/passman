# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_09_175933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "passwords", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "password"
    t.text "description"
    t.string "iv"
    t.string "salt"
    t.integer "password_strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "password_updated_at"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_passwords_on_user_id"
  end

  create_table "secure_notes", force: :cascade do |t|
    t.string "title"
    t.string "iv"
    t.string "salt"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_secure_notes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.jsonb "preferences"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "passwords", "users"
  add_foreign_key "secure_notes", "users"
end
