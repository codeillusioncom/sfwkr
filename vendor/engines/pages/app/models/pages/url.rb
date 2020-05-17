module Pages
  class Url < ApplicationRecord
    has_many :menu_items, as: :menuable
  end
end