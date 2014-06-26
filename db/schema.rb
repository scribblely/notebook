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

ActiveRecord::Schema.define(version: 20140626015851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: true do |t|
    t.text    "text"
    t.integer "page_id"
  end

  add_index "annotations", ["page_id"], name: "index_annotations_on_page_id", using: :btree

  create_table "comment_flags", force: true do |t|
    t.integer "comment_id"
    t.integer "user_id"
  end

  add_index "comment_flags", ["comment_id", "user_id"], name: "index_comment_flags_on_comment_id_and_user_id", unique: true, using: :btree

  create_table "comment_replies", id: false, force: true do |t|
    t.integer  "comment_id"
    t.integer  "reply_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_replies", ["comment_id", "reply_id"], name: "index_comment_replies_on_comment_id_and_reply_id", unique: true, using: :btree

  create_table "comment_statuses", force: true do |t|
    t.string "name"
  end

  create_table "comments", force: true do |t|
    t.text    "content"
    t.integer "user_id"
    t.integer "comment_status_id"
    t.integer "annotation_id"
    t.float   "rating",            default: 0.0
  end

  add_index "comments", ["annotation_id"], name: "index_comments_on_annotation_id", using: :btree

  create_table "connections", force: true do |t|
    t.integer  "user_id"
    t.string   "source"
    t.string   "source_id"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["user_id", "source"], name: "user_source_constraint", unique: true, where: "(((source)::text = (source)::text) AND (user_id = user_id))", using: :btree

  create_table "entities", force: true do |t|
    t.string   "base_domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entities", ["base_domain"], name: "index_entities_on_base_domain", unique: true, using: :btree

  create_table "pages", force: true do |t|
    t.string   "url"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
  end

  add_index "pages", ["url"], name: "index_pages_on_url", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "email"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.boolean  "positive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["comment_id"], name: "index_votes_on_comment_id", using: :btree

end
