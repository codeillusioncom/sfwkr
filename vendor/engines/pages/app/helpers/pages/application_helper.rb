module Pages
  module ApplicationHelper
    def pages_render_menu_item(menu_item)
      href = '#'
      if menu_item.menuable_type == 'Pages::Page'
        href = pages.page_path(menu_item.menuable_id)
      end
      link_to menu_item.title, href, class: 'nav-link'
    end
  end
end
