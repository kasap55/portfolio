Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :tasks, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      patch :toggle_status
    end
  end
end
