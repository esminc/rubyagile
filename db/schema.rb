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

ActiveRecord::Schema.define(version: 20111104111851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title",      default: "",    null: false
    t.text     "body",       default: "",    null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publishing", default: false
    t.text     "summary"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kareki_entries", force: true do |t|
    t.string   "title",                                       null: false
    t.text     "content",                                     null: false
    t.string   "link",                                        null: false
    t.datetime "published_at",                                null: false
    t.string   "creator"
    t.integer  "feed_id",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation", limit: 16, default: "not_yet", null: false
  end

  add_index "kareki_entries", ["confirmation"], name: "index_kareki_entries_on_confirmation", using: :btree

  create_table "kareki_feeds", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.string   "url"
    t.string   "etag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["name"], name: "index_pages_on_name", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_histories_on_item_and_table_and_month_and_year", using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "fullname"
    t.string   "amazon_associate"
    t.boolean  "nakanohito"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
