Rails.application.routes.draw do
  apipie
  namespace :api do
    resources :exercises
    resources :coaches
    resources :clients do
      resources :trainings
    end
  end
end
