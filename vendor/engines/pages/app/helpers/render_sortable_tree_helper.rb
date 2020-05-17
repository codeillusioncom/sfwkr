# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }' class='the_sortable_tree-item'>
            <div class='ptz_table w100p p5 the_sortable_tree-item_content'>
              <div class='ptz_tr'>
                <div class='ptz_td vam w30'>
                  #{ handler }
                </div>

                <div class='ptz_td vam'>
                  #{ show_link }
                </div>

                <div class='ptz_td vam br-off w10 pr5'>
                  #{ controls }
                </div>
              </div>
            </div>

            #{ children }
          </li>
        "
      end

      def handler
        "<div class='the_sortable_tree-handler p5'>
          <i class='fa fa-arrows fs16'></i>
        </div>"
      end

      def show_link
        node = options[:node]
        ns = options[:namespace]
        # url = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)
        url = h.url_for(controller: '/pages/menu_items', action: :edit, id: node.id, menu_id: node.menu.id)
        title_field = options[:title]

        "<div class='fs15'>
          #{ h.link_to(node.send(title_field), url) }
        </div>"
      end

      def controls
        # Pages::MenuItem
        node = options[:node]

        #edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        #destroy_path = h.url_for(:controller => options[:klass].pluralize, :action => :destroy, :id => node)
        edit_link = h.link_to h.pages.edit_menu_menu_item_path(node), class: 'btn btn-warning' do
          '<i class="fa fa-edit fs20"></i>'.html_safe
        end
        destroy_link = h.link_to h.pages.menu_menu_items_path(node), data: {confirm: 'Are you sure?'}, method: :delete, class: 'btn btn-danger' do
          '<i class="fa fa-trash fs20"></i>'.html_safe
        end

        "
          #{edit_link}
          #{destroy_link}
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='the_sortable_tree-nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
