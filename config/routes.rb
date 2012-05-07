Dailythings::Application.routes.draw do
  get "comments/new"

  get "comments/create"

  root :to => "home#index"
  match "welcome", :to => "welcome#index"

  devise_for :users

  scope "view"do
    resources :feats do
      member do
        get :checkin
      end
    end
    resources :checkins do
      collection do
        get :friends
        get :epics
      end
    end
    resources :challenges
  end

  resources :comments
  match "member/:id", :to => "member#index", :as => :member

  get "settings", :to => "settings#account"
  get "settings/password", :to => "settings#password"
  put "settings/password", :to => "settings#password_update"
  get "settings/notifications", :to => "settings#notifications"
  get "settings/account", :to => "settings#account"
  put "settings/update", :to => "settings#update"

end
