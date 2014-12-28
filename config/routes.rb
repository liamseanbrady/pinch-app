PinchApp::Application.routes.draw do
  root to: 'goals#index'

  resources :goals, only: [:index, :new, :create, :show]
  resources :categories, only: [:new, :create]
end
