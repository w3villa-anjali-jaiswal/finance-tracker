Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  get 'stocks/search'
  get 'users/my_portfolio'
  root 'welcome#index'
  devise_for :users
  get 'my_portfolio' ,to: 'users#my_portfolio'
  get 'search_stock' ,to: 'stocks#search'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
