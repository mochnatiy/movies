# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    root to: 'home#index'

    namespace :api do
      namespace :v1 do
        resources :movies, only: %i(index create destroy update)
        resources :categories, only: %i(index)
      end
    end
  end
end
