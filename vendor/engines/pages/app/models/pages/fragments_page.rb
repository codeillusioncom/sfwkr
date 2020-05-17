module Pages
  class FragmentsPage < ApplicationRecord
    belongs_to :fragment, class_name: 'Pages::Fragment'
    belongs_to :page, class_name: 'Pages::Page'
  end
end