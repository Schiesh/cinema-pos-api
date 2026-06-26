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

ActiveRecord::Schema[8.1].define(version: 2026_06_26_155850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "state_id", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "movies", force: :cascade do |t|
    t.boolean "coming_soon_toggle", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "duration"
    t.string "genre"
    t.string "poster_url"
    t.decimal "price"
    t.string "rating"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "screenings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "movie_id"
    t.decimal "price"
    t.bigint "screen_id"
    t.integer "screen_number"
    t.integer "seats_available"
    t.integer "seats_total"
    t.datetime "showtime"
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_screenings_on_screen_id"
  end

  create_table "screens", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.bigint "location_id", null: false
    t.string "name", null: false
    t.string "screen_type", default: "Standard", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_screens_on_location_id"
  end

  create_table "seat_map_rows", force: :cascade do |t|
    t.integer "aisle_after_seat"
    t.datetime "created_at", null: false
    t.boolean "has_aisle", default: false, null: false
    t.string "row_letter", null: false
    t.bigint "seat_map_id", null: false
    t.integer "seats_per_row", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_map_id"], name: "index_seat_map_rows_on_seat_map_id"
  end

  create_table "seat_maps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "rows", default: 1, null: false
    t.bigint "screen_id", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_seat_maps_on_screen_id"
  end

  create_table "seats", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "label", null: false
    t.integer "position", null: false
    t.bigint "seat_map_row_id", null: false
    t.string "seat_type", default: "standard", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_map_row_id"], name: "index_seats_on_seat_map_row_id"
  end

  create_table "site_settings", force: :cascade do |t|
    t.integer "booking_cutoff_minutes", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "time_zone", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_states_on_abbreviation", unique: true
  end

  create_table "themes", force: :cascade do |t|
    t.string "background_color"
    t.datetime "created_at", null: false
    t.string "danger_color"
    t.string "info_color"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "success_color"
    t.string "text_color"
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_email"
    t.string "customer_name"
    t.decimal "price"
    t.integer "screening_id"
    t.string "seat_number"
    t.string "seat_type", default: "standard"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.string "employee_id"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "phone"
    t.string "pin_digest"
    t.integer "pin_length", default: 4, null: false
    t.jsonb "preferences", default: {}
    t.string "role", default: "cashier", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id", unique: true
  end

  add_foreign_key "locations", "states"
  add_foreign_key "screenings", "screens"
  add_foreign_key "screens", "locations"
  add_foreign_key "seat_map_rows", "seat_maps"
  add_foreign_key "seat_maps", "screens"
  add_foreign_key "seats", "seat_map_rows"
end
