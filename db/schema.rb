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

ActiveRecord::Schema.define(version: 20180804154240) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "day"
    t.string   "date"
    t.string   "time"
    t.string   "venue"
    t.text     "event_ticket_code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "header_image"
    t.string   "slug"
  end

  create_table "city_logo_dependencies", force: :cascade do |t|
    t.integer "city_id"
    t.integer "sponsor_logo_id"
    t.integer "index"
  end

  create_table "schedule_panels", force: :cascade do |t|
    t.integer "schedule_id"
    t.string  "time"
    t.string  "title"
  end

  create_table "schedule_panels_speakers", force: :cascade do |t|
    t.integer "speaker_id"
    t.integer "schedule_panel_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "city_id"
    t.string  "slug"
  end

  create_table "speakers", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "avatar"
    t.string   "email"
    t.string   "bio"
    t.string   "website"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsor_logos", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "logo",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "link"
    t.integer  "home_index"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: "", null: false
    t.string   "name",                 default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status",               default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
