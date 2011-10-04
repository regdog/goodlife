GoodLife::Application.routes.draw do
  root :to => "welcome#index"

  devise_for :user, :controllers => {:omniauth_callbacks=>'user/omniauth_callbacks'} do
    get 'profile', :to => "devise/registrations#edit", :as=>'profile'
  end
  match '/user' => "feats#index", :as => :user_root
  resources :authentications

  resources :feats, :only => [:index, :show] do
    get 'checkin', :on => :member
    get 'all', :on => :collection
  end

  resources :rewards, :only => [:index, :show] do
    get 'all', :on => :collection
  end

  resources :checkins, :only => [:index] do
    collection do
      get 'my_challenges'
      get 'all'
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
    resources :feats, :rewards, :challenges, :partners, :categories, :contents
    resources :users, :only => [:index, :show, :destroy]
  end

end
