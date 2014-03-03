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

ActiveRecord::Schema.define(version: 20140226194008) do

  create_table "activities", force: true do |t|
    t.string "name",        null: false
    t.text   "description"
  end

  create_table "activity_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "species_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_users", ["user_id", "species_id"], name: "index_activity_users_on_user_id_and_species_id"

  create_table "classes", force: true do |t|
    t.string   "class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          default: 0, null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "img_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_species", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "species_id"
  end

  add_index "groups_species", ["group_id", "species_id"], name: "index_groups_species_on_group_id_and_species_id", unique: true

  create_table "groups_users", id: false, force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_users", ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", unique: true

  create_table "models", force: true do |t|
    t.integer  "species_id"
    t.string   "img_url"
    t.date     "model_date"
    t.string   "author"
    t.text     "description"
    t.integer  "rating",      default: 0
    t.boolean  "validated",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb_url"
    t.boolean  "current",     default: true
  end

  add_index "models", ["species_id", "current"], name: "index_models_on_species_id_and_current"

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "model_id"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "model_id"
    t.text     "geoJSON"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["model_id"], name: "index_reviews_on_model_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "species", force: true do |t|
    t.integer  "class_id"
    t.string   "sci_name"
    t.string   "order"
    t.string   "family"
    t.string   "sib_url"
    t.integer  "ocurrence_records"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ocurrence_records_url"
  end

  add_index "species", ["class_id"], name: "index_species_on_class_id"
  add_index "species", ["sci_name"], name: "index_species_on_sci_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "location"
    t.string   "organization"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatarUrl"
    t.string   "interestGroups"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
