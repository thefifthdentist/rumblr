ActiveRecord::Schema.define(version: 2018_05_03_203722) do

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "subject"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
