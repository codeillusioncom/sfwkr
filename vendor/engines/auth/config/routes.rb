Auth::Engine.routes.draw do
  devise_for :users, class_name: 'Auth::User', module: :devise
end
