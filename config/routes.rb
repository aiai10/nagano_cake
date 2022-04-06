Rails.application.routes.draw do
  devise_for :customers, controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
  }
  
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do
   root to: 'homes#top'
   get 'about' => 'homes#about'
   resources :items, only: [:index, :show]
  end

  namespace :admin do
   get 'top' => 'homes#top'
   resources :items, only: [:index, :new, :create, :show, :edit]
  end
end
