Rails.application.routes.draw do
  root "welcome#index"

  mount Attachinary::Engine => "/attachinary"

  resources :cocktails, only: [:index, :new, :show, :create, :destroy] do
    resources :doses, only: [:new, :create]
  end

  delete '/doses/:id', to: "doses#destroy", as: "dose"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
