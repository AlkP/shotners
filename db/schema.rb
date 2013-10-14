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

ActiveRecord::Schema.define(version: 20131010104845) do

  create_table "shotners", force: true do |t|
    t.text     "original_url"
    t.text     "shortened_url"
    t.integer  "usage_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_link"
    t.string   "password_link"
    t.integer  "user_id"
  end

  add_index "shotners", ["user_id"], name: "index_shotners_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "country"
  end

end
