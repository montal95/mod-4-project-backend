Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes, only:[:update,:create,:destroy]
      post '/users', to: 'users#create'
      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end
  end
end