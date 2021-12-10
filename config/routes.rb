Rails.application.routes.draw do
  # resources :transactions

  #Custom routes:
  get '/balance', to: 'transactions#index'
  post '/add_transaction', to: 'transactions#create'
  put '/spend_points', to: 'transactions#spend'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
