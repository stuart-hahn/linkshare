Rails.application.routes.draw do

  root "links#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :categories do
    resources :links
  end
  
  resources :links do
    post :upvote, on: :member
    post :downvote, on: :member
  end

  get '/newest', to: 'links#newest'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
