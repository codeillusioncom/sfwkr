Blog::Engine.routes.draw do
  resources :blogs do
    resources :posts
    get 'posts/by_year_and_month/:year/:month' => 'posts#by_year_and_month', :as=> :posts_by_year_and_month
    get 'posts/by_tag/:tag' => 'posts#by_tag', as: :posts_by_tag
  end
end
