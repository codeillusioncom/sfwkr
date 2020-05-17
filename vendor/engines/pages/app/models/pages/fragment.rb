module Pages
  class Fragment < ApplicationRecord
    has_and_belongs_to_many :pages
  end
end