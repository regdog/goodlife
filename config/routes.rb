GoodLife::Application.routes.draw do
  root :to => "welcome#index"

  devise_for :users, :controllers => {:omniauth_callbacks=>'users/omniauth_callbacks', :registrations => 'users/registrations'} do
    get 'profile', :to => "users/registrations#edit", :as=>'profile'
  end
  match '/users' => "feats#index", :as => :user_root

  resources :authentications

  devise_for :admin_users, :path => "/admin/users"

  scope "/view" do
    resources :checkins, :only => [:index, :create] do
      resources :comments
      collection do
        get 'latest'
        get 'epic'
      end
    end
    resources :feats, :only => [:index, :show] do
      get 'catalog', :on => :collection
      get 'checkin', :on => :member
    end
    match 'feats/:id/plan/:type' => 'feats#plan', :as => 'plan_feats'

    get 'plans' => "plans#index"
    get 'plans/daily' => "plans#daily", :as => "daily_plans"
    get 'plans/weekly' => "plans#weekly", :as => "weekly_plans"
    get 'plans/weekend' => "plans#weekend", :as => "weekend_plans"

    resources :challenges, :except => :destroy do
      get 'mine', :on => :collection
      get 'date', :on => :collection
      get 'popularity', :on => :collection
      get 'points', :on => :collection
      get 'accept', :on => :member
      get 'leave', :on => :member
    end

    resources :rewards, :only => [:index, :show] do
      get 'local', :on => :collection
      get 'premium', :on => :collection
      get 'wishlist', :on => :collection
      get 'add_wish', :on => :member
      get 'remove_wish', :on => :member
    end
  end

  resources :redemptions, :only => [:create]
  get '/rewards/redeem/:reward_id' => 'redemptions#new', :as => :new_redemption


  get 'team' => "team#index", :as => :teammates
  get 'team/checkins' => "team#checkins", :as => :team_checkins
  get 'team/requests' => "team#requests", :as => :my_requests
  get 'team/invite' => "team#invite", :as => :invite_member

  get 'member/:nameid' => "member#show", :as => :member

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
    resources :tags do
      get 'feat_tag_tokens', :on => :collection
      get 'reward_tag_tokens', :on => :collection
    end
    resources :rewards, :challenges, :partners, :categories, :contents
    resources :users, :only => [:index, :show, :destroy]
  end

end
