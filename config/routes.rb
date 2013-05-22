Moeil::Application.routes.draw do
  devise_for :mailboxes, path: '',
    path_names: {sign_in: 'login', sign_out: 'logout' }

  resource :password, only: [:show, :update]

  resources :domains, only: [:index] do
    resources :mailboxes, only: [:show, :index, :destroy]
  end

  devise_scope :mailbox do
    root to: 'devise/sessions#new'
  end
end
