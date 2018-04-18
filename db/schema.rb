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

ActiveRecord::Schema.define(version: 20180413152357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.bigint "coach_id"
    t.string "mail_address", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.string "last_name", null: false
    t.boolean "is_pending", default: true
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "diet_plan_file_name"
    t.string "diet_plan_content_type"
    t.integer "diet_plan_file_size"
    t.datetime "diet_plan_updated_at"
    t.index ["coach_id"], name: "index_clients_on_coach_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.string "mail_address", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mail_address"], name: "index_coaches_on_mail_address", unique: true
  end

  add_foreign_key "clients", "coaches", on_delete: :cascade
end
