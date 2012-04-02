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

ActiveRecord::Schema.define(:version => 20120305083938) do

  create_table "buildings", :force => true do |t|
    t.string   "name",       :limit => 30, :default => "", :null => false
    t.string   "address",    :limit => 80, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inbound", :force => true do |t|
    t.integer  "ip",    :null => false
    t.datetime "ts",    :null => false
    t.integer  "bytes", :null => false
  end

  add_index "inbound", ["ts", "ip"], :name => "idx_ip_ts", :unique => true

  create_table "ips", :primary_key => "ip", :force => true do |t|
    t.integer  "person_id"
    t.integer  "building_id"
    t.string   "room"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.boolean  "free"
  end

  create_table "outbound", :force => true do |t|
    t.integer  "ip",    :null => false
    t.datetime "ts",    :null => false
    t.integer  "bytes", :null => false
  end

  add_index "outbound", ["ts", "ip"], :name => "idx_ip_ts", :unique => true

  create_table "persons", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_seen"
  end

end
