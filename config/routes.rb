Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'matches' => 'matches#index'
  get 'matches/:id' => 'matches#show'
  get 'matches/:id/kills_per_weapon' => 'matches#kills_per_weapon'

  get "up" => "rails/health#show", as: :rails_health_check
end
