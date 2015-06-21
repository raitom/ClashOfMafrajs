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

ActiveRecord::Schema.define(version: 20150621160630) do

  create_table "armees", force: :cascade do |t|
    t.integer  "mafraj_id"
    t.integer  "zamel",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "mafrajs", force: :cascade do |t|
    t.integer  "user_id",                                                null: false
    t.string   "nom"
    t.integer  "theiere",                default: 0
    t.integer  "chicha",                 default: 0
    t.integer  "the",                    default: 0
    t.integer  "fumee",                  default: 0
    t.integer  "zamel",                  default: 0
    t.integer  "nigger",                 default: 1
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "kebab",                  default: 0
    t.integer  "niveau",                 default: 1
    t.float    "the_a_recolter",         default: 0.0
    t.float    "fumee_a_recolter",       default: 0.0
    t.datetime "derniere_recolte_fumee", default: '2015-06-21 16:10:58'
    t.datetime "derniere_recole_the",    default: '2015-06-21 16:10:58'
    t.datetime "date_fin_construction"
    t.string   "type_construction"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
