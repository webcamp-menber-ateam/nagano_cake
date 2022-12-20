Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get "/about"=>"homes#about"
    resources :products, only: [:index, :show]
    resource :customers,only: [] do
      get "my_page"=>"customers#show"
      get "information/edit"=>"customers#edit"
      patch "information"=>"customers#update"
      get "unsubscribe"=>"customers#unsubscribe"
      patch "withdrawal"=>"customers#withdrawal"
    end
    resources :carts, only: [:index, :update, :create, :destroy] do
      collection do
        delete "destroy_all"=>"carts#destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"=>"orders#confirm"
        get "complete"=>"orders#complete"
      end
    end
    resources :addresses, except: [:new, :show]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :products, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update] do
      get "orders" => "customers#orders"
    end
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

end
