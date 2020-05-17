class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_orders do |t|
      t.string "name"
      t.string "email"
      t.text "address"
      t.string "pay_method"

      t.timestamps
    end
    add_index :webshop_orders, :name
    add_index :webshop_orders, :email
  end
end
