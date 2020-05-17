module Webshop
  class ProductsController < ApplicationController
    def index
      @products = policy_scope(::Webshop::Webshop)
      authorize @products

      respond_to do |format|
        format.html
        format.json { render json: @products }
      end
    end

    def show
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @product = ::Webshop::Product.find(params[:id])
      authorize @product
      render :show, layout: 'webshop'
    end

    def new
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @product = ::Webshop::Product.new
      authorize @product
      render :new, layout: 'webshop'
    end

    def create
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @product = ::Webshop::Product.new

      @product.update_attributes(product_params)
      @product.webshop_id = @webshop.id
      authorize @product

      respond_to do |format|
        if @product.save
          format.html { redirect_to webshop.webshop_path(@webshop), notice: 'Product was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @product = ::Webshop::Product.find(params[:id])
      authorize @product
      render :edit, layout: 'webshop'
    end

    def update
      @webshop = ::Webshop::Webshop.find(params[:webshop_id])
      @product = ::Webshop::Product.find(params[:id])
      authorize @product

      if @product.update_attributes(permitted_attributes(@product))
        redirect_to webshop.webshop_product_path(@webshop, @product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product = ::Webshop::Webshop.find(params[:id])
      authorize @product

      @product.delete
      redirect_to pages.pages_path, notice: 'Page was successfully deleted.'
    end

    private

    def product_params
      params.require(:product).permit(policy(@product).permitted_attributes)
    end
  end
end
