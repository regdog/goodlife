GoodLife::Application.routes.draw do
  get "plans/index"

  get "plans/all"

  get "plans/daily"

  get "plans/weekly"

  get "plans/weekend"

  root :to => "welcome#index"

  devise_for :users, :controllers => {:omniauth_callbacks=>'users/omniauth_callbacks'} do
    get 'profile', :to => "devise/registrations#edit", :as=>'profile'
  end
  match '/users' => "feats#index", :as => :user_root

  resources :authentications

  devise_for :admin_users

  resources :feats, :only => [:index, :show] do
    get 'checkin', :on => :member
    get 'all', :on => :collection
  end

  resources :rewards, :only => [:index, :show] do
    get 'all', :on => :collection
  end

  resources :checkins, :only => [:index] do
    collection do
      get 'latest'
      get 'epic'
    end
  end

  match 'corp/:permalink' => 'contents#show'
  get 'search/index', :as => :search

  get 'kindeditor/images_list'
  post 'kindeditor/upload'

  namespace :admin do
       # Directs /admin/products/* to Admin::ProductsController
       # (app/controllers/admin/products_controller.rb)
    root :to => "dashboard#index"
    resources :feats do
      get 'feat_tokens', :on => :collection
    end
    resources :rewards, :challenges, :partners, :categories, :contents
    resources :users, :only => [:index, :show, :destroy]
  end

end
