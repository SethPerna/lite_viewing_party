Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  resources :users, only: %i[show create]
  get '/users/:id/discover', to: 'users#discover'
end
