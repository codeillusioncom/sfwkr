class ThemeManager
  #
  # - felolvassa a témákat
  # - tárolja a témákat és az adatait
  # - a kiválasztott témát telepíti
  # - a kiválasztott témát törli
  #
  def initialize
    @themes = Dir.entries("#{Rails.root}/app/themes").select { |entry| entry != '.' && entry != '..' }
    @theme_properties = {}
    @themes.each do |theme|
      parse_theme(theme)
    end
  end

  def properties(theme_name)
    {
        fragments: fragments(theme_name)
    }
  end

  def fragments(theme_name)
    @theme_properties[theme_name]['fragments']
  end

  def pages(theme_name)
    @theme_properties[theme_name]['pages']
  end

  def themes
    @themes
  end

  def theme_properties
    @theme_properties
  end

  def install(theme_name)
    common_fragments = []
    pages(theme_name).each do |page_name|
      name = page_name['name']
      object_type = page_name['type']
      fragments = page_name['fragments']
      menu_names = page_name['add_to_menu']
      object = nil
      title = 'unknown'
      if object_type == 'page'
        root = page_name['root']
        published = page_name['published']
        page = Pages::Page.create!(title: name, content: '', published: published, root: root)
        object = page
        title = name
        i = 0
        fragments.each do |fragment|
          fragment_name = fragment['name']
          fragment_common = fragment['common']
          fragment_properties = fragment['properties']
          # már volt ez a nevű fragment
          if common_fragments.include?(fragment_name)
            if fragment_common
              fragment_created = Pages::Fragment.where(fragment_name: fragment_name, common: true).first
              common_fragments << fragment_name
            else
              # mégis létrehozzuk common :false-al
              fragment_created = Pages::Fragment.create!(theme_name: Settings::Setting.get_system_setting('theme'), fragment_name: fragment_name, order: i, value: fragment_properties.to_json, common: false)
            end
          else
            # nem volt még ez a nevű fragment, megnézzük létezik-e?
            fragment_created = Pages::Fragment.where(theme_name: Settings::Setting.get_system_setting('theme'), fragment_name: fragment_name, common: fragment_common).try(:first)
            # már létezik, felülírjuk
            if fragment_created
              # létrehoztuk
              if fragment_common
                common_fragments << fragment_name
              else
                #
              end
              fragment_created.order = i
              fragment_created.value = fragment_properties.to_json
              fragment_created.save!
              # nem létezik, létrehozzuk
            else
              # Nem létezik, létrehozzuk
              if fragment_common
                common_fragments << fragment_name
              else
                #
              end
              fragment_created = Pages::Fragment.create!(theme_name: Settings::Setting.get_system_setting('theme'), fragment_name: fragment_name, order: i, value: fragment_properties.to_json, common: fragment_common)
            end
          end
          page.fragments << fragment_created unless page.fragments.include?(fragment_created)
          i += 1
        end
      elsif object_type == 'url'
        href = page_name['properties']['href']
        target = page_name['properties']['target'] || '_self'
        title = page_name['properties']['title']
        url = Pages::Url.create!(href: href, target: target, theme_name: Settings::Setting.get_system_setting('theme'))
        object = url
      elsif object_type == 'blog'
        if Blog::Blog.count == 0
          blog = Blog::Blog.create!
        else
          blog = Blog::Blog.first
        end
        title = page_name['properties']['title']
        object = blog
      elsif object_type == 'webshop'
        if Webshop::Webshop.count == 0
          webshop = Webshop::Webshop.create!
        else
          webshop = Webshop::Webshop.first
        end
        title = page_name['properties']['title']
        object = webshop
      else
        puts "invalid object_type #{object_type}"
      end
      add_to_menu(menu_names, object, title) #if menu_names
    end
  end

  def add_to_menu(menu_names, object, title)
    menu_names.each do |menu_name|
      # get menu
      menu = Pages::Menu.where(menu_type: menu_name).try(:first)
      # create if does not exists
      unless menu
        menu = Pages::Menu.create!(menu_type: menu_name)
      end
      # get menuitem if exists
      menuitem = Pages::MenuItem.where(menu_id: menu.id, title: title, menuable: object).try(:first)
      # create menuitem if does not exists
      unless menuitem
        # TODO: parent_id
        menuitem = Pages::MenuItem.create!(menu_id: menu.id, title: title, menuable: object)
      end
      # add to menu
      menuitem.menuable = object
      menuitem.save!
    end if menu_names
  end

  def uninstall(theme_name)
    pages(theme_name).each do |page_name|
      name = page_name['name']
      fragments = page_name['fragments']
      menu_names = page_name['add_to_menu']
      puts "destroy #{name}"
      page = Pages::Page.where(title: name).try(:first)
      if page
        page.destroy
      end
      Pages::Fragment.where(theme_name: Settings::Setting.get_system_setting('theme')).delete_all
      Pages::Url.where(theme_name: Settings::Setting.get_system_setting('theme')).delete_all
    end
  end

  private

  def parse_theme(theme_name)
    properties = JSON.parse(File.read("#{Rails.root}/app/themes/#{theme_name}/properties.json"))
    @theme_properties[theme_name] = properties
  end
end