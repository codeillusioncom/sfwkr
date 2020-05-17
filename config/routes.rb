Rails.application.routes.draw do
  get 'home/show'

  root 'home#show'

  mount Auth::Engine, at: '/auth'
  mount Blog::Engine, at: '/blog'
  mount Pages::Engine, at: '/pages'
  mount Settings::Engine, at: '/settings'
  mount Webshop::Engine, at: '/webshop'
end
