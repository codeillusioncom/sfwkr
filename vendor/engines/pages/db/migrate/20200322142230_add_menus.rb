class AddMenus < ActiveRecord::Migration[5.2]
  def up
    Pages::Menu.create(menu_type: 'header_menu')
    Pages::Menu.create(menu_type: 'main_menu')
    Pages::Menu.create(menu_type: 'footer_menu')
  end

  def down

  end
end
