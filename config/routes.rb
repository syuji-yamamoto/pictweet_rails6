Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :tweets do
    collection do
      get 'search'
    end
    resources :comments, only: :create
  end
  resources :users, only: :show
end
