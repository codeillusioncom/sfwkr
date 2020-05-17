module Pages
  class MenusController < ApplicationController
    def index
      @menus = policy_scope(Pages::Menu)
      authorize @menus
    end

    def show
      @menu = Menu.find(params[:id])
      @menu_items = MenuItem.where(user_id: current_user.id)
      authorize @menu
    end

    def new
      @page = Menu.new
      authorize @page
    end

    def create
      @page = Menu.new
      authorize @page

      params[:page][:user_id] = current_user.id
      @page.update_attributes(page_params)

      respond_to do |format|
        if @page.save
          format.html { redirect_to pages.pages_path, notice: 'Menu was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @page = Menu.find(params[:id])
      authorize @page
    end

    def update
      @page = Menu.find(params[:id])
      authorize @page

      params[:page][:user_id] = current_user.id

      if @page.update_attributes(permitted_attributes(@page))
        redirect_to pages.pages_path, notice: 'Menu was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @page = Menu.find(params[:id])
      authorize @page

      @page.delete
      redirect_to pages.pages_path, notice: 'Menu was successfully deleted.'
    end

    def manage
      @menu_items = MenuItem.nested_set.select('id, title0        , parent_id').all
    end

    private

    def page_params
      params.require(:menu).permit(policy(@menu).permitted_attributes)
    end
  end
end
