# frozen_string_literal: true

Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path
  passwordless_for :admins, at: "/ready_room"

  sitepress_pages
  sitepress_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :videos do
    resources :subscribers, only: %i(create)
    resource :unsubscribe, only: %i(new destroy)
  end

  namespace :ready_room do
    resource :dashboard, only: %i(show)
  end
end
