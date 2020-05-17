module ApplicationHelper
  def render_path(menu_item)
    if menu_item.menuable.class.name == 'Pages::Page'
      pages.page_path(menu_item.menuable)
    elsif menu_item.menuable.class.name == 'Pages::Url'
      menu_item.menuable.href
    elsif menu_item.menuable.class.name == 'Blog::Blog'
      blog.blog_posts_path(menu_item.menuable)
    elsif menu_item.menuable.class.name == 'Webshop::Webshop'
      webshop.webshop_path(menu_item.menuable)
    end
  end

  def render_link(menu_item)
    if ['Pages::Page', 'Blog::Blog'].include?(menu_item.menuable.class.name)
      link_to(menu_item.title, render_path(menu_item), class: 'nav-link')
    elsif menu_item.menuable.class.name == 'Pages::Url'
      link_to(menu_item.title, render_path(menu_item), target: menu_item.menuable.target, class: 'nav-link')
    elsif menu_item.menuable.class.name == 'Webshop::Webshop'
      if (current_user && current_user.has_role?(:system))






        str = "<li class=\"nav-item dropdown\">"




        str += "<a class=\"dropdown-toggle nav-link\" data-toggle=\"dropdown\" data-delay=\"0\" data-close-others=\"false\" href=\"\">" + menu_item.title + " (#{Webshop::Order.count}) "
        str += "<i class=\"fa fa-angle-down\"></i></a>"
        str += '<div role="menu" class="dropdown-menu">'
        str += link_to('Go to the Shop...', webshop.webshop_path(menu_item.menuable), role: 'presentation', class: 'dropdown-item')
        str += link_to('Show Orders...', webshop.webshop_orders_path(menu_item.menuable), role: 'presentation', class: 'dropdown-item')
        str += '</div>'

        # TODO: webshop_id legyen az orderben és csak azokat mutassa, ami az adott webshop-hoz tartozik
        str.html_safe
      else
        link_to menu_item.title, render_path(menu_item), class: 'nav-link'
      end
    end
  end

  def can_see(menu_item)
    if ['Pages::Page', 'Blog::Blog', 'Webshop::Webshop'].include?(menu_item.menuable.class.name)
      policy(menu_item.menuable).show?
    elsif menu_item.menuable.class.name == 'Pages::Url'
      true
    end
  end

  def get_menu_tree
    @menus = Pages::MenuItem.nested_set_scope.select('id, title, parent_id, menu_id').all
  end
end
