Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pawns#index"

  resources :pawns, only: :index do
    collection do
      post :move
      get :log
    end
  end
end
