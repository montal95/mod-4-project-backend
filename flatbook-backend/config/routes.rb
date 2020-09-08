Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes, only:[:index,:show,:update,:create,:destroy]
      resources :users, only:[:show,:create,:update,:destroy]
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
  end
end