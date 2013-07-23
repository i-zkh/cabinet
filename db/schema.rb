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

ActiveRecord::Schema.define(:version => 20130718091452) do

  create_table "address_ranges", :force => true do |t|
    t.string   "city"
    t.string   "street"
    t.integer  "building"
    t.integer  "apartment"
    t.integer  "vendor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.integer  "vendor_type"
    t.integer  "merchantId"
    t.integer  "service_type_id"
    t.string   "auth_key",        :limit => nil
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

end
