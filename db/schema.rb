# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140113152114) do

  create_table "conversations", force: true do |t|
    t.string   "sender_id"
    t.string   "recipient_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "gallery_id"
  end

  create_table "letsgos", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.string   "tag"
    t.integer  "repost_from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "letsgos", ["user_id", "created_at"], name: "index_letsgos_on_user_id_and_created_at", using: :btree

  create_table "locations", force: true do |t|
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", force: true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id",                             null: false
    t.integer  "recipient_id"
    t.integer  "sender_deleted",      default: 0
    t.integer  "recipient_deleted",   default: 0
    t.string   "subject",                               null: false
    t.text     "body"
    t.datetime "read_at"
    t.string   "container",           default: "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conversation_id"
    t.string   "original_message_id"
    t.string   "ancestry"
  end

  add_index "messages", ["ancestry"], name: "index_messages_on_ancestry", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "event_type"
    t.string   "event_id"
    t.boolean  "read",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "amount",     default: 1
    t.string   "token"
    t.string   "identifier"
    t.string   "payer_id"
    t.boolean  "recurring",  default: false
    t.boolean  "digital",    default: false
    t.boolean  "popup",      default: false
    t.boolean  "completed",  default: false
    t.boolean  "canceled",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "name"
    t.string   "gallery_id"
    t.integer  "user_id"
  end

  create_table "questions", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "asked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "message_id"
  end

  create_table "relationships", force: true do |t|
    t.integer "follower_id"
    t.integer "followed_id"
  end

  create_table "searches", force: true do |t|
    t.string   "gender"
    t.string   "age"
    t.string   "zip_code"
    t.string   "children"
    t.string   "religion"
    t.string   "ethnicity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_age"
    t.integer  "max_age"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "zip_code"
    t.string   "birthday"
    t.string   "name"
    t.string   "username"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "sexuality"
    t.string   "career"
    t.string   "education"
    t.string   "religion"
    t.string   "politics"
    t.string   "children"
    t.string   "height"
    t.string   "user_smoke"
    t.string   "user_drink"
    t.string   "about_me"
    t.string   "inches"
    t.string   "feet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin"
    t.string   "role"
    t.integer  "roles_mask"
    t.integer  "age"
    t.integer  "default_photo_id"
    t.integer  "location_id"
    t.string   "time_zone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["zip_code"], name: "index_users_on_zip_code", using: :btree

end
