Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :offers, only: [:show,:create, :new]
  resources :flights, only: [:index, :create]
  # do
  #   collection do
  #     get 'index_back'
  #     post 'create_back'
  #   end
  # end
  resources :hotels, only: [:index, :create]
  resources :packaging_activities, only: [:index, :create]
  get "dashboard", to: "pages#dashboard"
end
