PinchApp::Application.routes.draw do
  root to: 'goals#index'

  get '/register', to: 'users#new', as: 'register'

  resources :users, only: [:create, :edit, :update, :show]
  resources :goals, except: [:destroy] do
    resources :learning_resources, only: [:new, :create]
    member do
      post :pinch
    end
  end
  resources :categories, only: [:new, :create]
end
