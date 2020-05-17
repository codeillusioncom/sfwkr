Webshop::Engine.routes.draw do
  resources :webshops do
    get 'carts/:id' => "carts#show", as: "cart"
    delete 'carts/:id' => "carts#destroy"
    post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
    post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
    put 'line_items/:id' => "line_items#create", as: 'line_items'
    get 'line_items/:id' => "line_items#show", as: "line_item"
    delete 'line_items/:id' => "line_items#destroy"

    resources :products
    resources :orders
  end
end
