Rails.application.routes.draw do
  root to: "home#index"
  resources :transactions, only: [:index, :show, :create]
end
