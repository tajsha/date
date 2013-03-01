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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130228160445) do

  create_table "galleries", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "photos", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.string   "name"
    t.integer  "gallery_id"
  end

  create_table "users", :force => true do |t|
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
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin"
    t.integer  "feet"
    t.integer  "inches"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
