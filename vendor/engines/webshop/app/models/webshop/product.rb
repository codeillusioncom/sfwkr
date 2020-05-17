module Webshop
  class Product < ApplicationRecord
  	has_many_attached :images
  end
end
