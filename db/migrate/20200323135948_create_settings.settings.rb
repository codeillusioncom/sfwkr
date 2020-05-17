# This migration comes from settings (originally 20200323135702)
class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings_settings do |t|
      t.integer :user_id
      t.string :key
      t.text :value
    end
    add_index :settings_settings, [:user_id, :key], unique: true
  end
end
