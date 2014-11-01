TheApp::Application.routes.draw do

  ## トップページ
  root to: 'base#index'

  ## ユーザー登録・認証
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/sign_up_confirm' => 'users/registrations#sign_up_confirm'
    get 'users/redirect_oauth/:provider' => 'users/omniauth#redirect_oauth', as: :redirect_oauth
  end
  resources :users, only: [:index, :show]

  ## 設定
  get 'settings/profile' => 'settings#profile', as: :settings_profile
  patch 'settings/profile' => 'settings#update_profile'
  get 'settings/oauth' => 'settings#oauth', as: :settings_oauth
  get 'settings/oauth/remove/:provider' => 'settings#oauth_remove', as: :settings_oauth_remove

  ## 問い合わせフォーム
  resources :contact, only: [:index, :create]

  ## 管理系
  namespace :admin do
    root to: 'base#index'
    resources :users do
      post :login, on: :member
    end
  end

  ## 静的ページ
  get ':path' => 'static_pages#static'

  ## 404 Not Found
  get '*unmatched_route' => 'application#raise_not_found!'

end
