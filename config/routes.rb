PinchApp::Application.routes.draw do
  root to: 'welcome#about'

  get '/about', to: 'welcome#about'
  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/notifications', to: 'users#notifications', as: 'notifications'

  resources :users, only: [:create, :edit, :update, :show] do
    member do
      get :dashboard
    end
  end
  resources :goals, except: [:destroy] do
    member do
      post :pinch
      post :drop
    end
    collection do
      get :search
    end
    resources :learning_resources, only: [:new, :create, :destroy] do
      member do
        post :like
      end
    end
    resources :contribution_requests, only: [:create, :destroy] do
      member do
        patch :accept
        patch :reject
        patch :mark_as_read
      end
    end
  end
  resources :categories, except: [:destroy]
  resources :pinch_notifications, only: [:destroy]
end
