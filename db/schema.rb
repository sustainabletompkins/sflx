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

ActiveRecord::Schema.define(version: 20161218153854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "email"
    t.string   "phone"
    t.string   "website"
    t.string   "city"
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings_lists", id: false, force: :cascade do |t|
    t.integer "list_id",    null: false
    t.integer "listing_id", null: false
  end

  add_index "listings_lists", ["list_id", "listing_id"], name: "index_listings_lists_on_list_id_and_listing_id", using: :btree
  add_index "listings_lists", ["listing_id", "list_id"], name: "index_listings_lists_on_listing_id_and_list_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.integer "category_id"
  end

end
