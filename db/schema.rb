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

ActiveRecord::Schema.define(version: 20131010143254) do

  create_table "galleries", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "gallery_id"
  end

  create_table "letsgos", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.string   "tag",                 limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repost_from_user_id"
  end

  add_index "letsgos", ["user_id", "created_at"], name: "index_letsgos_on_user_id_and_created_at", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id",                           null: false
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    default: false
    t.boolean  "recipient_deleted", default: false
    t.string   "subject",                             null: false
    t.text     "body"
    t.datetime "read_at"
    t.string   "container",         default: "draft"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "event_type"
    t.string   "event_id"
    t.boolean  "read",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.string   "name"
    t.string   "gallery_id"
    t.integer  "user_id"
  end

  create_table "questions", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "message_id"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "searches", force: true do |t|
    t.string   "gender"
    t.string   "zip_code"
    t.string   "children"
    t.string   "religion"
    t.string   "ethnicity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "min_age"
    t.integer  "max_age"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "zip_code"
    t.date     "birthday"
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
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin"
    t.string   "role"
    t.integer  "roles_mask"
    t.integer  "average_response_time"
    t.integer  "response_rate"
    t.integer  "response_total"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["zip_code"], name: "index_users_on_zip_code", using: :btree

  create_table "zips", id: false, force: true do |t|
    t.string   "code"
    t.string   "city"
    t.string   "state"
    t.decimal  "lat",        precision: 10, scale: 0
    t.decimal  "lon",        precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zips", ["code"], name: "index_zips_on_code", unique: true, using: :btree

end
