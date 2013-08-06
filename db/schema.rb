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

ActiveRecord::Schema.define(version: 20130806033905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: true do |t|
    t.string   "entry_id"
    t.datetime "published"
    t.datetime "updated"
    t.string   "title"
    t.text     "content"
    t.string   "author_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id"
  end

  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "feed_id"
    t.datetime "updated"
    t.string   "rights"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.string   "href"
    t.string   "rel"
    t.string   "type"
    t.string   "hreflang"
    t.string   "title"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feeds_id"
    t.integer  "entry_id"
  end

  add_index "links", ["entry_id"], name: "index_links_on_entry_id", using: :btree
  add_index "links", ["feeds_id"], name: "index_links_on_feeds_id", using: :btree

end
