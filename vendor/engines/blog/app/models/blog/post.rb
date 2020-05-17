module Blog
  class Post < ApplicationRecord
    acts_as_taggable_on :tags

    def my_tags
      tag_list.join(',')
    end

    def my_tags=(value)
      tag_list.remove(tag_list, parse: true)
      tag_list.add(value, parse: true)
    end

    def self.posts_months_count()
      select("COUNT( * ) AS posts, extract( month from created_at ) AS MONTH , extract(year from created_at ) AS YEAR").group("MONTH, YEAR").order("YEAR DESC, extract( month from created_at ) DESC")
    end
  end
end
