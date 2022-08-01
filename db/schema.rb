# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_01_092657) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companions", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trip_join_requests", force: :cascade do |t|
    t.integer "companions"
    t.integer "pets"
    t.integer "luggage"
    t.string "kids", default: [], array: true
    t.integer "stage"
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.jsonb "requesters_list", default: [], array: true
    t.index ["trip_id"], name: "index_trip_join_requests_on_trip_id"
    t.index ["user_id"], name: "index_trip_join_requests_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "origin"
    t.string "destinations", default: [], array: true
    t.integer "available_seats"
    t.datetime "departure_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.integer "pets"
    t.integer "luggage"
    t.integer "kids_age_range"
    t.integer "gasoline_comission"
    t.index ["user_id"], name: "index_trips_on_user_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.string "surname"
    t.string "nickname"
    t.integer "phone_number"
    t.string "email"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "model"
    t.boolean "air_conditioning"
    t.integer "vehicle_type"
    t.float "consumption"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "trip_join_requests", "trips"
  add_foreign_key "trip_join_requests", "users"
  add_foreign_key "trips", "users"
  add_foreign_key "trips", "vehicles"
  add_foreign_key "vehicles", "users"
end
