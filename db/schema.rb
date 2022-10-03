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

ActiveRecord::Schema[7.0].define(version: 2022_10_03_204331) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "container_events", force: :cascade do |t|
    t.uuid "container_id", null: false
    t.string "event_type"
    t.json "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["container_id"], name: "index_container_events_on_container_id"
  end

  create_table "containers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "barcode", default: "", null: false
    t.string "name", default: "", null: false
    t.uuid "container_id"
    t.uuid "user_id"
    t.uuid "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.string "category"
    t.boolean "is_item"
    t.integer "containers_count", default: 0, null: false
    t.index ["container_id"], name: "index_containers_on_container_id"
    t.index ["image_id"], name: "index_containers_on_image_id"
    t.index ["user_id"], name: "index_containers_on_user_id"
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "event_type"
    t.json "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "containers_count", default: 0, null: false
  end

  add_foreign_key "container_events", "containers"
  add_foreign_key "containers", "containers"
  add_foreign_key "containers", "images"
  add_foreign_key "containers", "users"
  add_foreign_key "user_events", "users"
  create_trigger("containers_before_insert_row_tr", :generated => true, :compatibility => 1).
      on("containers").
      before(:insert) do
    "UPDATE containers SET containers_count = containers_count + 1 WHERE id = NEW.container_id;"
  end

  create_trigger("containers_before_update_of_user_id_row_tr", :generated => true, :compatibility => 1).
      on("containers").
      before(:update).
      of(:user_id) do
    <<-SQL_ACTIONS
      UPDATE users
        SET containers_count = containers_count + 1
      WHERE id = NEW.user_id;
      UPDATE users
        SET containers_count = containers_count - 1
      WHERE id = OLD.user_id;
    SQL_ACTIONS
  end

  create_trigger("containers_before_update_of_container_id_row_tr", :generated => true, :compatibility => 1).
      on("containers").
      before(:update).
      of(:container_id) do
    <<-SQL_ACTIONS
      UPDATE containers
        SET containers_count = containers_count + 1
      WHERE id = NEW.container_id;
      UPDATE containers
        SET containers_count = containers_count - 1
      WHERE id = OLD.container_id;
    SQL_ACTIONS
  end

  create_trigger("containers_before_delete_row_tr", :generated => true, :compatibility => 1).
      on("containers").
      before(:delete) do
    "UPDATE containers SET containers_count = containers_count - 1 WHERE id = OLD.container_id;"
  end

end
