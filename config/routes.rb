Rails.application.routes.draw do
  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get '/update' ,to: 'users#edit'

  get '/delete', to: 'users#destroy'

  get '/view', to: 'users#show'

  get 'static_pages/home'

  get '/about', to: 'static_pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users
end
