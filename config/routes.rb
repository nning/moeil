Moeil::Application.routes.draw do
  devise_for :mailboxes, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { sessions: 'sessions' }

  resource :home,     only: [:show]
  resource :password, only: [:show, :update]

  namespace :admin do
    resources :domains, only: [:index, :destroy] do
      resources :mailboxes, only: [:destroy, :edit, :index, :update]
    end
  end

  resource :mailbox, only: [:edit, :update]

  devise_scope :mailbox do
    root to: 'sessions#new'
  end
end
