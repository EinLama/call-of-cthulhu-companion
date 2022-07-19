Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "investigators#index"

  resources :investigators

  post "/investigators/:id/skill_roll/:characteristic", to: "investigators#skill_roll", as: "skill_roll"
end
