Rails.application.routes.draw do
  get 'messages/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # devise_scope :user do
  #   delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end
  root to: 'pages#home'
  get "fblogin", to: "pages#fblogin"
  get "about", to: "pages#about"
  get "terms_and_conditions", to: "pages#terms_and_conditions"

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
    resources :chat_rooms, only: :show do
      resources :messages, only: :create
    end
  end

  get "test", to: "pages#test"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
