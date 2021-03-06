Rails.application.routes.draw do
  get '/login' ,to: 'sessions#new'
  post '/login' ,to: 'sessions#create'

  delete '/logout' ,to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get '/delete', to: 'users#destroy'

  get '/view', to: 'users#show'

  get 'static_pages/home'

  get '/about', to: 'static_pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
