Rails.application.routes.draw do
  get 'friend_invitations/index'
  get 'friend_invitations/new'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
