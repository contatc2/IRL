Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  resources :users, only: %i[index show update] do
    resources :user_adjectives, only: %i[index new create update]
  end
  resources :friend_invitations, only: %i[new create update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
