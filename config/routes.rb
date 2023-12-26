Rails.application.routes.draw do
  namespace :admin do
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    root to: "homes#top"
  end

 scope module: :public do
    resources :items, only: [:index, :show]
      get "customers/unsubscribe" => "customers#unsubscribe"
      patch "customers/withdraw" => "customers#withdraw"
      get "customers/my_page" => "customers#show"
      get "customers/infomation/edit" => "customers#edit"
      patch "customers/infomation" => "customers#update"
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all" => "cart_items#destroy_all"
      end
    end
   resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get "thanks" => "orders#thanks"
        post "confirm" => "orders#confirm"
      end
    end
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    root to: "homes#top"
    get "about" => "homes#about"
  end

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


