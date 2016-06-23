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

ActiveRecord::Schema.define(version: 20160622132532) do

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.integer  "venue_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "events", ["venue_user_id"], name: "index_events_on_venue_user_id"

  create_table "space_entries", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "event_id"
    t.integer  "space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "space_entries", ["event_id"], name: "index_space_entries_on_event_id"
  add_index "space_entries", ["space_id"], name: "index_space_entries_on_space_id"

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spaces", ["venue_id"], name: "index_spaces_on_venue_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  create_table "venue_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "activated_at"
    t.string   "role",         default: "user"
  end

  add_index "venue_users", ["user_id", "activated_at"], name: "index_venue_users_on_user_id_and_activated_at"
  add_index "venue_users", ["user_id", "venue_id"], name: "index_venue_users_on_user_id_and_venue_id", unique: true
  add_index "venue_users", ["user_id"], name: "index_venue_users_on_user_id"
  add_index "venue_users", ["venue_id"], name: "index_venue_users_on_venue_id"

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "venues", ["subdomain"], name: "index_venues_on_subdomain", unique: true

end
