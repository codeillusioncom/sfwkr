module Pages
  class PagesController < ApplicationController
    def index
      @pages = policy_scope(Pages::Page)
      authorize @pages

      respond_to do |format|
        format.html
        format.json { render json: @pages }
      end
    end

    def show
      @page = Page.find(params[:id])
      authorize @page
    end

    def new
      @page = Page.new
      authorize @page
    end

    def create
      @page = Page.new

      @page.update_attributes(page_params)
      @page.company_id = current_user.companies.first.id
      authorize @page

      respond_to do |format|
        if @page.save
          format.html { redirect_to pages.pages_path, notice: 'Page was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @page = Page.find(params[:id])
      authorize @page
    end

    def update
      @page = Page.find(params[:id])
      authorize @page

      params[:page][:user_id] = current_user.id

      if @page.update_attributes(permitted_attributes(@page))
        redirect_to pages.pages_path, notice: 'Page was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @page = Page.find(params[:id])
      authorize @page

      @page.delete
      redirect_to pages.pages_path, notice: 'Page was successfully deleted.'
    end

    private

    def page_params
      params.require(:page).permit(policy(@page).permitted_attributes)
    end
  end
end
