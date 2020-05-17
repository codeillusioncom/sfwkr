class CreateFragments < ActiveRecord::Migration[5.2]
  def change
    # TODO: cleanup-nál ez törlődjön
    create_table :pages_fragments do |t|
      t.string :theme_name
      t.string :fragment_name
      t.integer :order, default: 0
      t.json :value
      t.boolean :common, default: false

      t.timestamps
    end
    add_index :pages_fragments, [:theme_name]

    create_table :pages_fragments_pages, id: false do |t|
      t.integer :fragment_id
      t.integer :page_id

      t.timestamps
    end
    add_index :pages_fragments_pages, [:page_id, :fragment_id]
  end
end
