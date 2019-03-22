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

  resources :users, only: %i[index show update] do
    collection do
      get 'single_or_not'
      get 'availability'
    end
    resources :user_adjectives, only: %i[new create edit update]
  end

  resources :referrals, only: %i[create update] do
    collection do
      post 'share'
    end
  end
  resources :friend_invitations, only: %i[new create update]


  resources :matches, only: %i[new create update show] do
    get 'messages', to: 'messages#create'
  end

  get 'test', to: 'pages#test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
