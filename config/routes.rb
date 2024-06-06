Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
  resources :users, only: :show
  resources :recommendations, only: :index
  resources :lists, only: %i[show create]
  resources :movies, only: %i[index show] do
    resources :list_movies, only: %i[create]
    resources :movies_watched, only: %i[create]
  end
  resources :chatrooms
  get "user/lists" => "lists#index", as: :user_lists
  get "user/lists/:id/edit" => "lists#edit", as: :user_list_edit
  patch "lists/:id" => "lists#update", as: :settings_list_update
  delete "user/lists/:id" => "lists#destroy", as: :user_list_destroy

end
