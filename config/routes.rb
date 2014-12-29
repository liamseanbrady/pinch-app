PinchApp::Application.routes.draw do
  root to: 'goals#index'

  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:create, :edit, :update, :show]
  resources :goals, except: [:destroy] do
    resources :learning_resources, only: [:new, :create]
    member do
      post :pinch
      post :drop
    end
  end
  resources :categories, only: [:new, :create]
end
