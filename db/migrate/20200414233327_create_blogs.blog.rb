# This migration comes from blog (originally 20200414232348)
class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_blogs do |t|

      t.timestamps
    end
  end
end
