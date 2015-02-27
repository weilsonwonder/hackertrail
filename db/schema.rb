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

ActiveRecord::Schema.define(version: 20150227144445) do

  create_table "accounts", force: true do |t|
    t.text     "email"
    t.text     "encrypted_password"
    t.text     "salt"
    t.text     "token"
    t.text     "ttype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attrs", force: true do |t|
    t.text     "name"
    t.text     "value"
    t.integer  "position"
    t.integer  "event_id"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "ttype"
    t.text     "privacy_type"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", force: true do |t|
    t.integer  "account_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.text     "privacy_type"
    t.integer  "account_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.text     "name"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: true do |t|
    t.text     "name"
    t.text     "ttype"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
