Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events do
    resources :attendances, only: [:index]
    resources :charges, only: [:new, :create]
    resources :images, only: [:create]
  end
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
