Moeil::Application.routes.draw do
  devise_for :mailboxes

  resource :password, only: [:show, :update]

  root to: 'passwords#show'
end
