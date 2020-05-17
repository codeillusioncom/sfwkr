class CreateMenus < ActiveRecord::Migration[5.2]
  def change
  create_table :pages_menus do |t|
      t.string :menu_type

      t.timestamps
    end

    create_table :pages_menu_items do |t|
      t.integer :menu_id
      t.string :title
      t.references :menuable, polymorphic: true

      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps
    end

    add_index :pages_menu_items, [:menu_id]
    add_index :pages_menu_items, [:menuable_id, :menuable_type]
  end
end
