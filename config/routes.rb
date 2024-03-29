Rails.application.routes.draw do
  get 'matches' => 'matches#index'
  get 'matches/:id' => 'matches#show'
  get 'matches/:id/kills_per_weapon' => 'matches#kills_per_weapon'

  require 'sidekiq/web'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


    mount Rswag::Ui::Engine => '/api-docs'
    mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  # root "posts#index"
end
