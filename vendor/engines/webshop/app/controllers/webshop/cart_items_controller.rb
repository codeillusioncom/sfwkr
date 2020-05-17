module Webshop
  class CartItemsController < ApplicationController
    before_action :set_cart, only: [:create, :destroy]

    def create
      @cart.add_product(cart_params)

      if @cart.save
        redirect_to webshop.cart_path
      else
        flash[:error] = 'There was a problem adding this item to your cart.'
        redirect_to main_app.root_path
      end
    end

    def destroy
      @cart_item.destroy
      redirect_to cart_path
    end

    private

    #def page_params
    #  params.require(:page).permit(policy(@webshop).permitted_attributes)
    #end
  end
end
