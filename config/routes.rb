Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  resources :users, only: %i[show create] do
    resources :movies, only: %i[show index create], controller: :users_movies do
      resources :parties, only: %i[new create], controller: :users_movies_parties
    end
  end
  get '/users/:id/discover', to: 'users#discover'
  post '/users/:id/discover', to: 'users#discover'
end
