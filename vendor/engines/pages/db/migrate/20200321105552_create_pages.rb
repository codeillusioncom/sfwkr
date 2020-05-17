class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages_pages do |t|
      t.string :title
      t.text :content
      t.boolean :published, default: false
      t.boolean :root, default: false, index: true
    end
  end
end
