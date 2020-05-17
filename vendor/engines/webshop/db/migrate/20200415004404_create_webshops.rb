class CreateWebshops < ActiveRecord::Migration[5.2]
  def change
    create_table :webshop_webshops do |t|
      # pénznem, stb stb beállítások

      t.timestamps
    end
  end
end
