Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'
  get 'users/login', to: 'users#login'

  resources :users do
    member do
      get 'calendar'
    end
  end

end
