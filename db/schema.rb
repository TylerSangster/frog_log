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

ActiveRecord::Schema.define(version: 20130822190814) do

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "format"
    t.text     "description"
    t.integer  "cost"
    t.string   "cost_type"
    t.string   "provider"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_photo"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
    t.string   "avatar"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
