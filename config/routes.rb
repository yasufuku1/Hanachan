Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  scope module: :public do
    root to: 'homes#top'
    get "about"=>'homes#about'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only:[:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      collection do
        patch "unsubscribe"=>"users#unsubscribe"
        patch "withdraw"=>"users#withdraw"
      end
    end
    resources :posts do
      resource :favorites, only: [:create,:destroy]
      resources :post_comments, only: [:create,:destroy]
      collection do
        get "search"=>'posts#search',as: 'search'
      end
    end
    resources :notifications, only: :index
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
  end
end
