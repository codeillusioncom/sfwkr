require 'devise'
require 'pundit'
# require 'rolify'

module Auth
  class Engine < ::Rails::Engine
    isolate_namespace Auth
  end
end
