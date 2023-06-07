Rails.application.routes.draw do


  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  # ゲストログイン用
    devise_scope :user do
      post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  #ユーザー側
    root to: 'public/homes#top'
    get '/about' => 'public/homes#about'

    scope module: :public do

      get 'users/:id/confirm' => 'users#confirm', as: 'confirm'
      patch 'users/:id/resign' => 'users#resign', as: 'resign'
      get 'users/favorites' => 'users#favorites', as: 'favorites'
      resources :users, only: [:show, :edit, :update]

      resources :posts, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
        resource :favorites, only: [:create, :destroy]
        resources :comments, only: [:create, :destroy]
      end

    end

  # 管理者側
    namespace :admin do
      get 'homes/top'
      resources :users, only: [:show, :edit, :update]
      resources :comments, only: [:index, :destroy]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
