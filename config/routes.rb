Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :home, only: [:index]
  get "users/reservations", to: "home#reservations"
  get "users/loans", to: "home#my_loans"
  resources :books
  resources :journals
  resources :users, only: [:index]
  resources :reservations
  resources :loans

  scope "api/v1", defaults: {format: :json} do
    resources :home, only: [:index]
  end

  root 'home#index'
end
