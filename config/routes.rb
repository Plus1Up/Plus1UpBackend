Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :coaches
  end
  namespace :api do
    resources :clients
  end
  namespace :api do
    resources :diet_plans
  end
end
