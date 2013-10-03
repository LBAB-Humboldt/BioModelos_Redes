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

ActiveRecord::Schema.define(version: 20131003164029) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "models", force: true do |t|
    t.integer  "species_id"
    t.string   "url"
    t.date     "mode_date"
    t.string   "author"
    t.text     "description"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["species_id"], name: "index_models_on_species_id"

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
    t.string   "species_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "species", ["species_name"], name: "index_species_on_species_name", unique: true

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "role"
    t.string   "location"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
