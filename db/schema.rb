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

ActiveRecord::Schema.define(version: 2020_09_12_222506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_tags", force: :cascade do |t|
    t.integer "card_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id", "tag_id"], name: "index_on_card_id_and_tag_id", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "inactive_list_subtags", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id", "tag_id"], name: "index_on_list_id_and_tag_id", unique: true
  end

  create_table "list_tags", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id", "tag_id"], name: "index_list_tags_on_list_id_and_tag_id", unique: true
  end

  create_table "lists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.string "sort_by", default: "created_at", null: false
    t.string "show_option", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "tags", "users"
end
