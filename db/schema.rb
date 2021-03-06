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

ActiveRecord::Schema[7.0].define(version: 2022_07_24_155200) do
  create_table "investigators", force: :cascade do |t|
    t.string "name"
    t.integer "str"
    t.integer "con"
    t.integer "dex"
    t.integer "int"
    t.integer "siz"
    t.integer "pow"
    t.integer "app"
    t.integer "edu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rolls", force: :cascade do |t|
    t.string "target"
    t.integer "rolled_value"
    t.integer "investigator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigator_id"], name: "index_rolls_on_investigator_id"
  end

  add_foreign_key "rolls", "investigators"
end
