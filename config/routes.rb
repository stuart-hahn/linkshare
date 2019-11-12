Rails.application.routes.draw do

  root "links#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :categories
  resources :links
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
