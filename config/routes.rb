Rails.application.routes.draw do
  root "dashboard#index"

  resources :boards do
    resources :lists, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch :move
      end
    end
    resources :cards, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch :move
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end