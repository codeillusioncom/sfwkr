Pages::Engine.routes.draw do
  resources :menus do
    resources :menu_items do
      collection do
        get :manage
        post :rebuild
      end
    end
  end
  resources :pages do
    resources :fragments
  end
  resources :urls
end
