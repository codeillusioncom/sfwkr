module Pages
  class MenuItem < ApplicationRecord
    include TheSortableTree::Scopes
    include Rails.application.routes.url_helpers

    acts_as_nested_set #scope: :user

    belongs_to :menu
    belongs_to :menuable, polymorphic: true#, # TODO: dependent: :destroy

    # def get_path(h)
    #   url = ''
    #   begin
    #     if menuable.has_attribute?(:parseable) && menuable.parseable
    #       # TODO: HACK
    #       # We take the first part ex: swxpicture.galleries_path => swxpicture
    #       first = menuable.href.split('.')[0].to_sym
    #       engine = ''
    #       begin
    #         engine = h.controller_path.split('/').first if h.controller_path.split('/').size > 1
    #       rescue Exception => ee
    #       end
    #       if first != :main_app && (first.to_s != engine.to_s) && engine != ''
    #         # We take the URL from this part
    #         url  = eval("h.#{menuable.href}").split(engine.to_s).last
    #       else
    #         url = eval("h.#{menuable.href}")
    #       end
    #     else
    #       # url  = menuable.href(h.params.merge(:locale => h.locale))
    #       # TODO: is it safe?
    #       myparams = h.params
    #       myparams.delete :controller
    #       myparams.delete :action
    #       myparams.delete :id
    #       url = h.send(menuable.class.name.deconstantize.downcase).url_for([menuable, myparams])
    #     end
    #   rescue Exception => e
    #     # byebug
    #   end
    #   return url
    # end
  end
end