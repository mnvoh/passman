Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/sign_up', to: 'devise/registrations#create'
    post 'users/password/new', to: 'devise/passwords#create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main#index'
  get 'terms-of-service', to: 'main#tos'

  resources :passwords, except: [:show], constraints: { id: /[0-9]+/ } do
    member do
      post '', action: 'show', as: 'show'
      get '', action: 'unlock', as: 'unlock'
      post 'edit', action: 'edit', as: 'edit'
    end
  end
end
