Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "recommendations#index"
  resources :users, only: :show
  resources :recommendations, only: %i[index show]
  post "recommendation_favorite" => "recommendations#create_from_favorites", as: :recommendation_favorite
  post "recommendation_list/:id" => "recommendations#create_from_list", as: :recommendation_list

  resources :lists, only: %i[show create]
  resources :movies, only: %i[index create] do
    resources :list_movies, only: %i[create]
    resources :favorites, only: %i[create]
  end
  resources :favorites, only: %i[index create destroy]
  resources :watched_movies, only: %i[index create]
  resources :watch_later, only: %i[index]

  get "user/lists" => "lists#index", as: :user_lists
  get "user/lists/:id/edit" => "lists#edit", as: :user_list_edit
  patch "lists/:id" => "lists#update", as: :settings_list_update
  delete "user/lists/:id" => "lists#destroy", as: :user_list_destroy

  resources :chatrooms do
    resources :messages, only: :create
  end
end
