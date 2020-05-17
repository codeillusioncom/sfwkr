require 'the_sortable_tree'
require 'awesome_nested_set'

module Pages
  class Engine < ::Rails::Engine
    isolate_namespace Pages
  end
end
