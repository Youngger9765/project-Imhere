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


ActiveRecord::Schema.define(version: 20160221090201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.string   "participator"
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "content"
    t.text     "information"
    t.integer  "fund"
    t.integer  "shared_people"
    t.integer  "status"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "information_picture_file_name"
    t.string   "information_picture_content_type"
    t.integer  "information_picture_file_size"
    t.datetime "information_picture_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "description"
    t.string   "logo_in_event_file_name"
    t.string   "logo_in_event_content_type"
    t.integer  "logo_in_event_file_size"
    t.datetime "logo_in_event_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
  end

  add_index "activities", ["event_id"], name: "index_activities_on_event_id", using: :btree

  create_table "activity_milestones", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "people"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "content"
    t.integer  "shared_people"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
  end

  create_table "lotteries", force: :cascade do |t|
    t.integer  "activity_id"
    t.string   "name"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "users_count",       default: 0
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "merchantable_type"
    t.integer  "merchantable_id"
    t.text     "description"
    t.string   "name"
    t.text     "content"
    t.integer  "price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "order_number"
    t.string   "user_auth"
    t.integer  "user_id"
    t.integer  "product_id",            limit: 8
    t.string   "product_variant_title"
    t.integer  "product_quantity"
    t.string   "product_price"
    t.string   "subtotal_price"
    t.string   "currency"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "orders", ["order_number"], name: "index_orders_on_order_number", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree
  add_index "orders", ["user_auth"], name: "index_orders_on_user_auth", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selections", force: :cascade do |t|
    t.integer  "spec_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specs", force: :cascade do |t|
    t.integer  "merchant_id"
    t.string   "name"
    t.string   "selection"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_lottery_ships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lottery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_lottery_ships", ["lottery_id"], name: "index_user_lottery_ships_on_lottery_id", using: :btree
  add_index "user_lottery_ships", ["user_id"], name: "index_user_lottery_ships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.string   "fb_uid"
    t.string   "fb_token"
    t.text     "fb_raw_data"
    t.string   "authentication_token"
    t.string   "head_shot_file_name"
    t.string   "head_shot_content_type"
    t.integer  "head_shot_file_size"
    t.datetime "head_shot_updated_at"
    t.datetime "birthday"
    t.integer  "role_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "webhook_events", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "users", "roles"
end
