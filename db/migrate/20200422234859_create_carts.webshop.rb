# This migration comes from webshop (originally 20200423001725)
class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_carts do |t|

      t.timestamps
    end
  end
end
