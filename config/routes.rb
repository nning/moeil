Moeil::Application.routes.draw do
  devise_for :mailboxes, path: '',
    path_names: {sign_in: 'login', sign_out: 'logout' }

  resources :mailbox, only: [:show]

  resource :password, only: [:show, :update]

  devise_scope :mailbox do
    root to: 'devise/sessions#new'
  end
end
