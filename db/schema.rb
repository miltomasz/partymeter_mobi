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

ActiveRecord::Schema.define(:version => 20130211152509) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.integer  "city_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "clubs", ["city_id", "created_at"], :name => "index_clubs_on_city_id_and_created_at"

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "author"
  end

  add_index "comments", ["event_id", "created_at"], :name => "index_comments_on_event_id_and_created_at"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "event_date"
    t.text     "description"
    t.integer  "thumbup",     :default => 0
    t.integer  "thumbdown",   :default => 0
    t.integer  "club_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "events", ["club_id", "created_at"], :name => "index_events_on_club_id_and_created_at"

end
