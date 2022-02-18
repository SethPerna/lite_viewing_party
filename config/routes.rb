Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/dashboard', to: 'users#show'
  get '/dashboard/movies',  to: 'users_movies#index'
  post '/dashboard/movies', to: 'users_movies#create'
  get '/dashboard/movies/:id', to: 'users_movies#show'

  resources :users, only: %i[create] do '/users/:id/movies/:id/partie'
    resources :movies, only: %i[show create], controller: :users_movies do
      resources :parties, only: %i[new create], controller: :users_movies_parties
    end
  end
  get '/dashboard/discover', to: 'users#discover'
  post '/dashboard/discover', to: 'users#discover'
end
