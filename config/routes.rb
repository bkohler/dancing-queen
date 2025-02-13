Rails.application.routes.draw do
  root "queens#index"

  resources :queens, only: [ :index ] do
    resources :messages, only: [ :create ]
  end
end
