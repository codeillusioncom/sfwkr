module Webshop
  class WebshopsController < ApplicationController
    def index
      @webshops = policy_scope(::Webshop::Webshop)
      authorize @webshops

      respond_to do |format|
        format.html
        format.json { render json: @webshops }
      end
    end

    def show
      @webshop = ::Webshop::Webshop.find(params[:id])
      @products = WebshopPolicy::Scope.new(current_user, Product).resolve_products(@webshop)
      authorize @webshop
      render :show, layout: 'webshop'
    end

    def new
    @webshop = ::Webshop::Webshop.new
      authorize @webshop
    end

    def create
      @webshop = ::Webshop::Webshop.new

      @webshop.update_attributes(page_params)
      @webshop.company_id = current_user.companies.first.id
      authorize @webshop

      respond_to do |format|
        if @webshop.save
          format.html { redirect_to pages.pages_path, notice: 'Page was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @webshop = Webshop::Webshop.find(params[:id])
      authorize @webshop
    end

    def update
      @webshop = Webshop::Webshop.find(params[:id])
      authorize @webshop

      params[:page][:user_id] = current_user.id

      if @webshop.update_attributes(permitted_attributes(@webshop))
        redirect_to pages.pages_path, notice: 'Page was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @webshop = Webshop::Webshop.find(params[:id])
      authorize @webshop

      @webshop.delete
      redirect_to pages.pages_path, notice: 'Page was successfully deleted.'
    end

    private

    def page_params
      params.require(:page).permit(policy(@webshop).permitted_attributes)
    end
  end
end
