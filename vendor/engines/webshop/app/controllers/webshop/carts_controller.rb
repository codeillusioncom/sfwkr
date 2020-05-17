module Webshop
  class CartsController < ApplicationController
    def show
      # TODO: mindenki kosarát meg lehet nézni...kell egy egyedi azonosító és azt tenni a session-be
      @cart = @current_cart
      authorize @cart

      render :show, layout: 'webshop'
    end

    def destroy
      @cart = @current_cart
      authorize @cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to webshop.webshop_path(params[:webshop_id])
    end
  end
end
