Rails.application.routes.draw do

  ## Top page for application
  root 'base#index'

  ## API
  use_doorkeeper
  scope module: :api do
    scope '/v1', as: 'v1' do
      resources :users, only: [:index, :show, :update]
    end
  end

  ## User authentication
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/sign_up_confirm' => 'users/registrations#sign_up_confirm'
    get 'users/redirect_oauth/:provider' => 'users/omniauth_callbacks#redirect_oauth', as: :redirect_oauth
  end
  resources :users, only: [:index, :show]

  ## My settings
  get 'settings/profile' => 'settings#profile', as: :settings_profile
  patch 'settings/profile' => 'settings#update_profile'
  get 'settings/oauth' => 'settings#oauth', as: :settings_oauth
  get 'settings/oauth/remove/:provider' => 'settings#oauth_remove', as: :settings_oauth_remove

  ## Contact form
  resources :contact, only: [:index, :create]

  ## Admin
  namespace :admin do
    root 'base#index'
    resources :users do
      post :login, on: :member
    end
  end

  ## Static pages
  get ':path' => 'static_pages#static'

  ## 404 Not Found
  get '*unmatched_route' => 'application#raise_not_found!'

end
