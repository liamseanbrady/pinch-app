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

ActiveRecord::Schema.define(version: 20150130053522) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "contribution_permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contribution_requests", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "goal_id"
    t.datetime "viewed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
  end

  create_table "feedback", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "visibility",  default: "private"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "slug"
  end

  create_table "learning_resources", force: true do |t|
    t.string   "url"
    t.text     "summary"
    t.integer  "goal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pinch_notifications", force: true do |t|
    t.integer  "pincher_id"
    t.integer  "goal_creator_id"
    t.integer  "goal_id"
    t.datetime "viewed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pinch_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "tagline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "slug"
    t.string   "github_username"
  end

end
