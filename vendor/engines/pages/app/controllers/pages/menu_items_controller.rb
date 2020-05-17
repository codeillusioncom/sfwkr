module Pages
  class MenuItemsController < ApplicationController
    include TheSortableTreeController::Rebuild

    def index
      @menu = Menu.find(params[:menu_id])
      @menu_items = policy_scope(Pages::MenuItem)
      authorize @menu_items
    end

    def new
      @menu = Menu.find(params[:menu_id])
      @menu_item = @menu.menu_items.build
      authorize @menu_item
      render :new, layout: false
    end

    def create
      @menu = Menu.find(params[:menu_id])
      @menu_item = @menu.menu_items.build
      title = params[:menu_item][:title]
      menuable_type = params[:menu_item][:menuable_type]
      @menu_item.title = title
      @menu_item.menuable_type = menuable_type
      # @menu_item.update_attributes(menu_item_params)
      # @menu_item.menuable = menuable
      authorize @menu_item

      menuable = menuable_type.constantize.new
      @menu_item.menuable = menuable

      respond_to do |format|
        if @menu_item.save
          format.html { redirect_to pages.menu_path(@menu), notice: 'Menu item was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @menu = Menu.find(params[:menu_id])
      @menu_item = MenuItem.find(params[:id])
      authorize @menu_item
      render :edit, layout: false
    end

    def update
      @menu_item = MenuItem.find(params[:id])
      authorize @menu_item

      if @menu_item.update_attributes(permitted_attributes(@menu_item))
        redirect_to pages.page_path(@page), notice: 'Page was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @menu_item = MenuItem.find(params[:id])
      authorize @menu_item

      @menu_item.delete
      redirect_to pages.pages_path, notice: 'Menu was successfully deleted.'
    end

    protected

    def sortable_model
      [Pages::Menu.first, Pages:MenuItem]
    end

    def sortable_collection
      "menu_items"
    end

    private

    def menu_item_params
      params.require(:menu_item).permit(policy(@menu_item).permitted_attributes)
    end
  end
end
