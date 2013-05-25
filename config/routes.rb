Moeil::Application.routes.draw do
  devise_for :mailboxes, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { sessions: 'sessions' }

  resource :home,     only: [:show]
  resource :password, only: [:show, :update]

  resources :domains, only: [:index, :destroy] do
    resources :mailboxes, only: [:destroy, :edit, :index, :update, :show]
  end

  devise_scope :mailbox do
    root to: 'home#show'
  end
end
