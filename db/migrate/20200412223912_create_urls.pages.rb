# This migration comes from pages (originally 20200412223711)
class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :pages_urls do |t|
      t.string :href
      t.string :target
      t.string :theme_name

      t.timestamps
    end
  end
end
