# This migration comes from webshop (originally 20200415004404)
class CreateWebshops < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_webshops do |t|

      t.timestamps
    end
  end
end
