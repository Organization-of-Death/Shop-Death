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

ActiveRecord::Schema[7.0].define(version: 2022_11_15_160532) do
  create_table "inventories", force: :cascade do |t|
    t.decimal "price"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buyer_id"
    t.integer "seller_id"
    t.integer "item_id"
    t.index ["buyer_id"], name: "index_inventories_on_buyer_id"
    t.index ["item_id"], name: "index_inventories_on_item_id"
    t.index ["seller_id"], name: "index_inventories_on_seller_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "markets", force: :cascade do |t|
    t.decimal "price"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seller_id"
    t.integer "item_id"
    t.index ["item_id"], name: "index_markets_on_item_id"
    t.index ["seller_id"], name: "index_markets_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password"
    t.integer "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inventories", "Users", column: "buyer_id"
  add_foreign_key "inventories", "Users", column: "seller_id"
  add_foreign_key "inventories", "items"
  add_foreign_key "markets", "Users", column: "seller_id"
  add_foreign_key "markets", "items"
end
