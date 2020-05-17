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

ActiveRecord::Schema.define(version: 2020_05_17_034126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "auth_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_auth_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_auth_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_auth_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_auth_users_on_unlock_token", unique: true
  end

  create_table "auth_users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_auth_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_auth_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_auth_users_roles_on_user_id"
  end

  create_table "blog_blogs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.integer "blog_id"
    t.string "title"
    t.text "content"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_blog_posts_on_blog_id"
    t.index ["created_at"], name: "index_blog_posts_on_created_at"
    t.index ["published"], name: "index_blog_posts_on_published"
  end

  create_table "pages_fragments", force: :cascade do |t|
    t.string "theme_name"
    t.string "fragment_name"
    t.integer "order", default: 0
    t.json "value"
    t.boolean "common", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_name"], name: "index_pages_fragments_on_theme_name"
  end

  create_table "pages_fragments_pages", id: false, force: :cascade do |t|
    t.integer "fragment_id"
    t.integer "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id", "fragment_id"], name: "index_pages_fragments_pages_on_page_id_and_fragment_id"
  end

  create_table "pages_menu_items", force: :cascade do |t|
    t.integer "menu_id"
    t.string "title"
    t.string "menuable_type"
    t.bigint "menuable_id"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_pages_menu_items_on_lft"
    t.index ["menu_id"], name: "index_pages_menu_items_on_menu_id"
    t.index ["menuable_id", "menuable_type"], name: "index_pages_menu_items_on_menuable_id_and_menuable_type"
    t.index ["menuable_type", "menuable_id"], name: "index_pages_menu_items_on_menuable_type_and_menuable_id"
    t.index ["parent_id"], name: "index_pages_menu_items_on_parent_id"
    t.index ["rgt"], name: "index_pages_menu_items_on_rgt"
  end

  create_table "pages_menus", force: :cascade do |t|
    t.string "menu_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages_pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "published", default: false
    t.boolean "root", default: false
    t.index ["root"], name: "index_pages_pages_on_root"
  end

  create_table "pages_urls", force: :cascade do |t|
    t.string "href"
    t.string "target"
    t.string "theme_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "settings_settings", force: :cascade do |t|
    t.integer "user_id"
    t.string "key"
    t.text "value"
    t.index ["user_id", "key"], name: "index_settings_settings_on_user_id_and_key", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "webshop_carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webshop_line_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "product_id"
    t.integer "cart_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_webshop_line_items_on_cart_id"
    t.index ["order_id"], name: "index_webshop_line_items_on_order_id"
  end

  create_table "webshop_orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "address"
    t.string "pay_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_webshop_orders_on_email"
    t.index ["name"], name: "index_webshop_orders_on_name"
  end

  create_table "webshop_products", force: :cascade do |t|
    t.integer "webshop_id"
    t.string "name"
    t.text "description"
    t.decimal "net_price"
    t.decimal "tax", default: "0.0"
    t.string "sku"
    t.string "barcode"
    t.boolean "track_quantity"
    t.boolean "continue_selling_when_out_of_stock"
    t.decimal "available_pieces"
    t.boolean "physical_product", default: true
    t.integer "unit_name"
    t.decimal "unit_value"
    t.integer "country_of_origin"
    t.string "vendor"
    t.string "tags", array: true
    t.string "groups", array: true
    t.text "notes"
    t.index ["groups"], name: "index_webshop_products_on_groups", using: :gin
    t.index ["tags"], name: "index_webshop_products_on_tags", using: :gin
    t.index ["webshop_id"], name: "index_webshop_products_on_webshop_id"
  end

  create_table "webshop_webshops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "taggings", "tags"
end
