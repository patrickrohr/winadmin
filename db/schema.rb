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

ActiveRecord::Schema.define(version: 20160810151632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamedays", force: true do |t|
    t.date     "date"
    t.string   "location"
    t.string   "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "winner_id"
    t.boolean  "tie",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "gameday_id"
    t.datetime "deleted_at"
  end

  add_index "games", ["deleted_at"], name: "index_games_on_deleted_at", using: :btree

  create_table "gamesets", force: true do |t|
    t.integer  "game_id"
    t.integer  "number"
    t.integer  "points_team_1"
    t.integer  "points_team_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "gamesets", ["deleted_at"], name: "index_gamesets_on_deleted_at", using: :btree

  create_table "leagues", force: true do |t|
    t.integer  "number"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", force: true do |t|
    t.string   "name"
    t.integer  "number_of_sets"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "points"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "game_count"
    t.integer  "number"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "goals_difference"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "rights_group_id"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
