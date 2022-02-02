Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  resources :users, only: %i[show create] do
    resources :movies, only: %i[index create], controller: :users_movies
  end
  get '/users/:id/discover', to: 'users#discover'
  post '/users/:id/discover', to: 'users#discover'
end
