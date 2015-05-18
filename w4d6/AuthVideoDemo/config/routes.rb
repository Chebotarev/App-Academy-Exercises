AuthDemo::Application.routes.draw do
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
end
