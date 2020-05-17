class HomeController < ApplicationController
  def show
    # TODO: menuable
    page = Pages::Page.where(root: true).try(:first)
    authorize page
    redirect_to pages.page_path(page)
  end
end
