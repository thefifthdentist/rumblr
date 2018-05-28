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

ActiveRecord::Schema.define(version: 0) do

  create_table "posts", id: false, force: :cascade do |t|
    t.text "title", null: false
    t.text "content", null: false
    t.text "img_url"
    t.date "created"
    t.date "updated"
  end

  create_table "user_posts", primary_key: ["user_id", "post_id"], force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.index ["user_id", "post_id"], name: "sqlite_autoindex_user_posts_1", unique: true
  end

  create_table "users", id: false, force: :cascade do |t|
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.text "email", null: false
    t.date "birthday", null: false
    t.text "username"
    t.text "password"
    t.index ["email"], name: "sqlite_autoindex_users_1", unique: true
    t.index ["username"], name: "sqlite_autoindex_users_2", unique: true
  end

end
