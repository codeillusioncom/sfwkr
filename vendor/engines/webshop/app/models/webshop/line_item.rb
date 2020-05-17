module Webshop
  class LineItem < ApplicationRecord
    belongs_to :product
    belongs_to :cart
    belongs_to :order, :optional => true

    # LOGIC
    def total_price
      self.quantity = 1 if self.quantity.nil?
      self.quantity * self.product.net_price
    end
  end
end
