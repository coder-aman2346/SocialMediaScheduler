require 'sidekiq/web'
Rails.application.routes.draw do
  # Admin interface for Sidekiq (requires authentication in production)
  mount Sidekiq::Web => '/sidekiq'


  # Your other routes
  #devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end

