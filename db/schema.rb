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

ActiveRecord::Schema.define(version: 20130816184148) do

  create_table "galleries", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "gallery_id"
  end

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
    t.integer  "asked_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sender_id"
    t.integer  "recipient_id"
  end

  create_table "searches", force: true do |t|
    t.string   "gender"
    t.string   "age"
    t.string   "zip_code"
    t.string   "children"
    t.string   "religion"
    t.string   "ethnicity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "age"
    t.string   "age_end"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
