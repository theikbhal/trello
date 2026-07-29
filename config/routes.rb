Rails.application.routes.draw do
  root "dashboard#index"

  resources :boards do
    member do
      get :export
    end
    resources :lists, only: [:new, :create, :edit, :update, :destroy] do
      member do
        patch :move
      end
    end
    resources :cards, only: [:new, :create, :show, :edit, :update, :destroy] do
      member do
        patch :move
      end
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :tags, only: [:index, :create]

  get "search", to: "search#index"
  get "help", to: "pages#help"
  get "onboarding", to: "pages#onboarding"
  get "why", to: "pages#why"

  get "up" => "rails/health#show", as: :rails_health_check
end