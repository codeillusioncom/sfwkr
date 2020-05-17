module Pages
  class FragmentsController < ApplicationController
    def index
      @fragments = policy_scope(Pages::Fragment)
      authorize @fragments
    end

    def show
      @fragment = Fragment.find(params[:id])
      authorize @fragment
    end

    def new
      @fragment = Fragment.new
      authorize @fragment
    end

    def create
      @fragment = Fragment.new

      @fragment.update_attributes(page_params)
      @fragment.company_id = current_user.companies.first.id
      authorize @fragment

      respond_to do |format|
        if @fragment.save
          format.html { redirect_to pages.pages_path, notice: 'Page was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: Fragment.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @page = Page.find(params[:page_id])
      @fragment = Fragment.find(params[:id])
      authorize @fragment
      render :edit, layout: false
    end

    def update
      @page = Page.find(params[:page_id])
      @fragment = Fragment.find(params[:id])
      authorize @fragment

      menudata = params[:fragment][:menudata]
      if menudata
        menu_item_old = nil
        JSON.parse(menudata).each do |menu_d|
          menu_id = menu_d['id']
          menu_item = Pages::MenuItem.find(menu_id)
          if menu_item_old
            menu_item.move_to_right_of(menu_item_old)
            MenuItem.rebuild!
          end
          menu_item_old = menu_item
        end
        params[:fragment].delete :menudata
      end

      if @fragment.update_attributes(fragment_params)
        redirect_to pages.page_path(@page), notice: 'Fragment was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @fragment = Fragment.find(params[:id])
      authorize @fragment

      @fragment.delete
      redirect_to pages.pages_path, notice: 'Page was successfully deleted.'
    end

    private

    def fragment_params
      # params.require(:fragment).permit(policy(@fragment).permitted_attributes)
      params.require(:fragment).permit(policy(@fragment).permitted_attributes)
    end
  end
end
