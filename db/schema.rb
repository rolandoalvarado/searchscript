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

ActiveRecord::Schema.define(version: 20140204194712) do

  create_table "classifications", force: true do |t|
    t.string   "c_make"
    t.string   "c_model"
    t.integer  "c_year"
    t.integer  "user_id",    default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_ratings", force: true do |t|
    t.integer  "cr_friendliness"
    t.integer  "cr_price_of_quality"
    t.integer  "cr_timeliness"
    t.integer  "cr_overall"
    t.integer  "comment_id",          default: 0, null: false
    t.integer  "user_id",             default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id",    default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    default: 0, null: false
  end

  create_table "merchants", force: true do |t|
    t.string   "m_business_name"
    t.string   "m_contact_name"
    t.string   "m_business_email"
    t.string   "m_business_phone_number"
    t.string   "m_business_address"
    t.string   "m_city"
    t.string   "m_state"
    t.string   "m_zip_code"
    t.boolean  "m_status",                default: true, null: false
    t.integer  "user_id",                 default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "responses", force: true do |t|
    t.text     "body"
    t.integer  "merchant_id", default: 0, null: false
    t.integer  "comment_id",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.boolean  "s_full_service"
    t.boolean  "s_change_oil"
    t.boolean  "s_tire_service"
    t.boolean  "s_engine_service"
    t.boolean  "s_auto_body"
    t.boolean  "s_smog_check"
    t.boolean  "s_high_performance"
    t.boolean  "s_diesel"
    t.boolean  "s_motorcyles"
    t.boolean  "s_brakes"
    t.boolean  "s_hybrids"
    t.boolean  "s_natural_gas_vehicles"
    t.integer  "merchant_id",            default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "u_username",        limit: 30
    t.string   "u_hashed_password"
    t.string   "u_salt"
    t.string   "u_email"
    t.string   "u_firstname"
    t.string   "u_lastname"
    t.string   "u_middlename"
    t.boolean  "u_newsletter",                 default: false, null: false
    t.string   "u_phone_number"
    t.boolean  "u_admin",                      default: false, null: false
    t.boolean  "u_status",                     default: true,  null: false
    t.string   "u_last_login_on"
    t.string   "u_last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_types", force: true do |t|
    t.boolean  "vt_all_types"
    t.boolean  "vt_classic_cars"
    t.boolean  "vt_european_care"
    t.boolean  "vt_japanese_imports"
    t.boolean  "vt_domestic"
    t.boolean  "vt_custom"
    t.boolean  "vt_other"
    t.integer  "merchant_id",         default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip_codes", force: true do |t|
    t.integer  "z_zip_code"
    t.string   "z_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "z_type"
    t.string   "z_primary_city"
    t.string   "z_acceptable"
    t.string   "z_unacceptable_cities"
    t.string   "z_state"
    t.string   "z_county"
    t.string   "z_timezone"
    t.integer  "z_area_code"
    t.float    "z_latitude"
    t.float    "z_longitude"
    t.string   "z_world_region"
    t.string   "z_country"
    t.integer  "z_decomissioned"
    t.integer  "z_estimated_population"
    t.string   "z_notes"
  end

end
