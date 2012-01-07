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

ActiveRecord::Schema.define(:version => 20111231151351) do

  create_table "allow_queries", :force => true do |t|
    t.integer  "domain_id"
    t.string   "name",       :null => false
    t.string   "clients",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "defaults", :force => true do |t|
    t.string   "ttl",        :default => "24h",               :null => false
    t.string   "mname",      :default => "ns1.example.com.",  :null => false
    t.string   "rname",      :default => "root.example.com.", :null => false
    t.string   "serial",     :default => "1",                 :null => false
    t.string   "refresh",    :default => "1h",                :null => false
    t.string   "retry",      :default => "10m",               :null => false
    t.string   "expire",     :default => "41d",               :null => false
    t.string   "minimum",    :default => "1h",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                             :null => false
    t.string   "domtype",    :default => "Native", :null => false
    t.string   "master"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_servers", :force => true do |t|
    t.integer  "default_id"
    t.string   "fqdn",       :null => false
    t.string   "ttl"
    t.string   "pref",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "name_servers", :force => true do |t|
    t.integer  "default_id"
    t.string   "fqdn",       :null => false
    t.string   "ttl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", :force => true do |t|
    t.integer  "domain_id"
    t.string   "name",                          :null => false
    t.string   "ttl"
    t.string   "recclass",   :default => "IN",  :null => false
    t.string   "rectype",                       :null => false
    t.string   "pref"
    t.string   "content"
    t.string   "mname"
    t.string   "rname"
    t.string   "serial"
    t.string   "expire"
    t.string   "refresh"
    t.string   "retry"
    t.string   "minimum"
    t.boolean  "locked",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "servername",    :null => false
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servers", ["servername"], :name => "index_servers_on_servername"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username",                           :null => false
    t.string   "password_hash"
    t.string   "fullname",                           :null => false
    t.string   "role",          :default => "Owner", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
