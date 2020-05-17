module Webshop
  class LineItemsController < ApplicationController
    def create
      # Find associated product and current cart
      chosen_product = Product.find(params[:id])
      current_cart = @current_cart

      authorize chosen_product

      # If cart already has this product then find the relevant line_item and iterate quantity otherwise create a new line_item for this product
      if current_cart.products.include?(chosen_product)
        # Find the line_item with the chosen_product
        @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
        puts @line_item.inspect
        puts "---"
        # Iterate the line_item's quantity by one
        @line_item.quantity = 0 if @line_item.quantity.nil?
        @line_item.quantity += 1
      else
        @line_item = LineItem.new
        @line_item.cart = current_cart
        @line_item.product = chosen_product
      end

      # Save and redirect to cart show path
      @line_item.save!
      puts @line_item.inspect
      puts @line_item.errors.inspect
      redirect_to webshop_cart_path(params[:webshop_id], current_cart)
    end

    private
    def line_item_params
      params.require(:line_item).permit(:quantity,:product_id, :cart_id)
    end
  end
end
