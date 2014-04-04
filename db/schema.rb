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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140404064116) do

  create_table "accounts", :force => true do |t|
    t.string   "user_account"
    t.string   "city"
    t.string   "street"
    t.string   "building"
    t.string   "apartment"
    t.integer  "vendor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.float    "invoice_amount"
  end

  create_table "address_ranges", :force => true do |t|
    t.string   "city"
    t.string   "street"
    t.integer  "building"
    t.integer  "apartment"
    t.integer  "vendor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bids", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "key"
    t.float    "installation_payment"
    t.string   "installation_payment_for_vendor"
    t.float    "service_payment"
    t.string   "service_payment_for_vendor"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "contract_number"
  end

  create_table "en_acccounts", :force => true do |t|
    t.string  "user_account"
    t.string  "city"
    t.string  "street"
    t.string  "building"
    t.string  "apartment"
    t.date    "bypass"
    t.integer "meter_reading"
    t.float   "invoice_amount"
    t.date    "data"
  end

  create_table "en_handlings", :force => true do |t|
    t.integer  "user_account"
    t.integer  "user_id"
    t.string   "remote_ip"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "payloads", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.float    "invoice_amount"
    t.integer  "invoice_date"
    t.integer  "vendor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "precinct_houses", :force => true do |t|
    t.integer  "precinct_id"
    t.integer  "street_id"
    t.string   "house"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "precincts", :force => true do |t|
    t.string   "ovd"
    t.string   "ovd_town"
    t.string   "ovd_street"
    t.string   "ovd_house"
    t.string   "ovd_telnumber"
    t.string   "surname"
    t.string   "name"
    t.string   "middlename"
    t.text     "photo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "streets", :force => true do |t|
    t.string   "street"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "territories", :force => true do |t|
    t.integer  "precinct_id"
    t.string   "street"
    t.string   "house"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_id_ranges", :force => true do |t|
    t.integer  "user_account"
    t.integer  "vendor_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "vendors", :force => true do |t|
    t.string   "title"
    t.integer  "account_number"
    t.integer  "user_id_type"
    t.string   "vendor_type",     :limit => nil
    t.integer  "merchantId"
    t.integer  "service_type_id"
    t.string   "auth_key",        :limit => nil
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "email"
    t.float    "commission"
    t.boolean  "distribution"
  end

end
