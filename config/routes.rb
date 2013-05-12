Moeil::Application.routes.draw do
  resource :password, only: [:show, :update]
# put '', controller: 'home#generate_hash'
  root to: 'passwords#show'
end
