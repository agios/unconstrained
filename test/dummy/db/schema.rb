# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2015_02_07_083618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "parents", id: :serial, force: :cascade do |t|
  end

  add_foreign_key "children", "parents"
end
