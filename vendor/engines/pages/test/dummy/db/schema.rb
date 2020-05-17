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

ActiveRecord::Schema.define(version: 2020_03_21_194401) do

  create_table "pages_menu_items", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "user_id"
    t.string "title"
    t.string "menuable_type"
    t.integer "menuable_id"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_pages_menu_items_on_lft"
    t.index ["menu_id", "user_id"], name: "index_pages_menu_items_on_menu_id_and_user_id"
    t.index ["menuable_id", "menuable_type"], name: "index_pages_menu_items_on_menuable_id_and_menuable_type"
    t.index ["menuable_type", "menuable_id"], name: "index_pages_menu_items_on_menuable_type_and_menuable_id"
    t.index ["parent_id"], name: "index_pages_menu_items_on_parent_id"
    t.index ["rgt"], name: "index_pages_menu_items_on_rgt"
  end

  create_table "pages_menus", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages_menutype_urls", force: :cascade do |t|
    t.string "href"
    t.boolean "parseable", default: false
    t.string "target", default: "self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages_pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.boolean "published", default: false
  end

end
