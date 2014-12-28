PinchApp::Application.routes.draw do
  root to: 'goals#index'

  resources :goals, except: [:destroy]
  resources :categories, only: [:new, :create]
end
