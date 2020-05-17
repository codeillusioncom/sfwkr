module Webshop
  class OrdersController < ApplicationController
    def index
      @orders = policy_scope(Order)
      authorize @orders
      render :index, layout: 'webshop'
    end

    def show
      @order = Order.find(params[:id])
      authorize @order
    end

    def new
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @order = ::Webshop::Order.new
      authorize @order
      render :new, layout: 'webshop'
    end

    def create
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @order = Order.new(order_params)
      authorize @order

      @current_cart.line_items.each do |item|
        @order.line_items << item
        item.cart_id = nil
      end
      @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to webshop.webshop_path(@webshop)
    end

    private

    def order_params
      params.require(:order).permit(policy(@order || Order.new).permitted_attributes)
    end
  end
end
