# This migration comes from blog (originally 20200414232414)
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_posts do |t|
      t.integer :blog_id, index: true
      t.string :title
      t.text :content
      t.boolean :published, default: :false

      t.timestamps
    end
    add_index :blog_posts, :created_at
    add_index :blog_posts, :published
  end
end
