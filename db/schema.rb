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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20130819184905) do

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=======
ActiveRecord::Schema.define(version: 20130819011809) do
>>>>>>> 1e68820592a6af294b9224ca84034acb9f3e9a1b

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
