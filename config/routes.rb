Rails.application.routes.draw do
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do
   root to: 'homes#top'
   get 'about' => 'homes#about'

   resources :items, only: [:index, :show]
   post 'orders/confirm(/:id)', to: 'orders#confirm', as: 'confirm_order'
   get 'orders/complete', to: 'orders#complete', as: 'complete_order'
   resources :orders, only: [:new, :create, :index, :show]
   resources :addresses, only: [:index, :edit, :create, :update, :destroy]
   patch 'customers/withdraw', to: 'customers#withdraw', as: 'withdraw_customer'
   get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe_customer'
   resources :customers, only: [:show, :edit, :update]
   resources :cart_items, only: [:index, :update, :create, :destroy] do
     collection do
     delete 'destroy_all'
    end
   end
  end

  namespace :admin do
   get 'top' => 'homes#top'
   patch 'order_details/update/:id', to: 'order_details#update', as: 'update_order_details'
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
  end
end
