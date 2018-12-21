Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/sign_up', to: 'devise/registrations#create'
    post 'users/password/new', to: 'devise/passwords#create'
  end

  root to: 'main#index'
  get 'terms-of-service', to: 'main#tos'
  get 'privacy-policy', to: 'main#privacy_policy'
  get 'about', to: 'main#about'

  resources :passwords, except: [:show], constraints: { id: /[0-9]+/ } do
    member do
      post '', action: 'show', as: 'show'
      get '', action: 'unlock', as: 'unlock'
      post 'edit', action: 'edit', as: 'edit'
    end
    get 'generate', action: 'generate', as: 'generate', on: :collection
  end

  resources :secure_notes, except: [:show], constraints: { id: /[0-9]+/ } do
    member do
      post '', action: 'show', as: 'show'
      get '', action: 'unlock', as: 'unlock'
      post 'edit', action: 'edit', as: 'edit'
    end
  end
end
