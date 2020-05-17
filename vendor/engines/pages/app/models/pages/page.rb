module Pages
  class Page < ApplicationRecord
    has_many :menu_items, as: :menuable
    has_and_belongs_to_many :fragments, dependent: :destroy
    accepts_nested_attributes_for :fragments, reject_if: :all_blank, allow_destroy: true
  end
end