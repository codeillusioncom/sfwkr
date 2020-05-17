class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_products do |t|
      t.integer :webshop_id, index: true
      t.string :name
      t.text :description
      # TODO: media url vagy konkrét, kép vagy videó
      # TODO: Options
      # TODO: Groups
      t.decimal :net_price
      t.decimal :tax, default: 0
      t.string :sku
      t.string :barcode
      t.boolean :track_quantity
      t.boolean :continue_selling_when_out_of_stock
      t.decimal :available_pieces
      t.boolean :physical_product, default: true
      t.integer :unit_name
      t.decimal :unit_value
      t.integer :country_of_origin
      t.string :vendor
      t.string :tags, array: true
      t.string :groups, array: true
      t.text :notes

      t.timestamps
    end
    add_index :webshop_products, :tags, using: 'gin'
    add_index :webshop_products, :groups, using: 'gin'
  end
end
