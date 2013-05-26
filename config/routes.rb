Moeil::Application.routes.draw do
  devise_for :mailboxes, path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { sessions: 'sessions' }

  resource :password, only: [:show, :update]

  namespace :admin do
    resources :domains, except: :show do
      resources :aliases, only: [:destroy, :index]
      resources :mailboxes, except: :show
    end
  end

  resource :mailbox, only: [:edit, :update]

  devise_scope :mailbox do
    root to: 'sessions#new'
  end
end
