Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'pages#home'
  get 'fblogin', to: 'pages#fblogin'
  get 'about', to: 'pages#about'
  get 'terms_and_conditions', to: 'pages#terms_and_conditions'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'test', to: 'pages#test'

  resources :users, only: %i[index edit show update] do
    collection do
      get 'single_or_not'
      get 'availability'
    end
  end

  resources :referrals, only: %i[create update] do
    collection do
      post 'share'
    end
  end

  resources :friend_invitations, only: %i[new create update]

  resources :matches, only: %i[new create update show]

  resources :chat_rooms, only: :show do
    resources :messages, only: :create
  end

  resources :pseudo_matches, only: %i[create update show]

  mount ActionCable.server => "/cable"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
