Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :coaches
  end
  namespace :api do
    resources :clients do
      resources :trainings
    end
  end
end
