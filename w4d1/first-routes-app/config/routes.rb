Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index]
  end

  resources :contacts, only: [:create, :destroy, :show, :update]
  resources :contact_shares, only: [:create, :destroy]
end
