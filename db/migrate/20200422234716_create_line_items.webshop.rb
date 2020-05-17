# This migration comes from webshop (originally 20200423001724)
class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_line_items do |t|
      t.integer :quantity
      t.integer :product_id
      t.integer :cart_id
      t.integer :order_id

      t.timestamps
    end
    add_index :webshop_line_items, :cart_id
    add_index :webshop_line_items, :order_id
  end
end
