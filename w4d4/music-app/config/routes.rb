MusicApp::Application.routes.draw do
  root 'bands#index'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]
end
