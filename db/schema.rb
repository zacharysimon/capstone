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

ActiveRecord::Schema.define(version: 20151210161107) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "listing_id",   limit: 4
    t.integer  "score",        limit: 4
    t.text     "comment",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "comment_type", limit: 255
  end

  create_table "listings", force: :cascade do |t|
    t.text     "street_adress",         limit: 65535
    t.string   "zip_code",              limit: 255
    t.string   "city",                  limit: 255
    t.string   "state",                 limit: 255
    t.float    "latitude",              limit: 24
    t.float    "longitude",             limit: 24
    t.string   "walk_score",            limit: 255
    t.string   "transit_score",         limit: 255
    t.integer  "rent_zestimate",        limit: 4
    t.string   "url",                   limit: 255
    t.integer  "tax_assessment",        limit: 4
    t.integer  "sqft",                  limit: 4
    t.string   "yearbuilt",             limit: 255
    t.string   "lastdatesold",          limit: 255
    t.integer  "lastsoldprice",         limit: 4
    t.integer  "bathrooms",             limit: 4
    t.integer  "bedrooms",              limit: 4
    t.text     "images",                limit: 65535
    t.integer  "zpid",                  limit: 4
    t.integer  "price",                 limit: 4
    t.integer  "mls_number",            limit: 4
    t.integer  "zws_id",                limit: 4
    t.string   "home_type",             limit: 255
    t.text     "walkscore_description", limit: 65535
    t.integer  "hoa_assessment",        limit: 4
    t.boolean  "rent_cap"
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                          default: "", null: false
    t.string   "encrypted_password",     limit: 255,                          default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "loan_type",              limit: 4
    t.decimal  "percent_down_pmt",                   precision: 10, scale: 4
    t.integer  "credit_score_bucket",    limit: 4
    t.decimal  "annual_insurance",                   precision: 10, scale: 2
    t.decimal  "acquisition_costs",                  precision: 10, scale: 2
    t.decimal  "disposition_costs",                  precision: 10, scale: 2
    t.decimal  "annual_maintenance",                 precision: 10, scale: 3
    t.decimal  "rent_growth",                        precision: 10, scale: 4
    t.decimal  "property_appreciation",              precision: 10, scale: 4
    t.decimal  "income_tax_rate",                    precision: 10, scale: 4
    t.decimal  "income",                             precision: 15, scale: 2
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
