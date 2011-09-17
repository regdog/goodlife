GoodLife::Application.routes.draw do
  get "content_nodes/show"

  get "checkins/index"

  get "rewards/index"

  get "rewards/new"

  get "rewards/create"

  get "feats/new"

  get "feats/create"

  get "feats/index"

  get 'checkins/index'
  resources :feats
  resources :rewards
  resources :authentications

  get 'search/index', :as => :search
  match 'checkins/myteam' => 'checkins#show_my_team'
  match 'checkins/mychallenges' => 'checkins#show_my_challenges'
  match 'checkins/all' => 'checkins#all'

  devise_for :users, :controllers => {:omniauth_callbacks=>'users/omniauth_callbacks'}
  match '/user' => "feats#index", :as => :user_root

  match 'feats/checkins/:feat_id' => 'feats#checkin'
  match 'corp/:permalink' => 'content_nodes#show', :as => 'corp'

  namespace :admin do
       # Directs /admin/products/* to Admin::ProductsController
       # (app/controllers/admin/products_controller.rb)
    get 'partners/list'
    get 'content_nodes/list'
    root :to => "dashboard#index"
    match 'admin/checkins' => 'checkins#index'
    resources :content_nodes
    resources :feats
    resources :feat_categories
    resources :rewards
    resources :reward_categories
    resources :challenges
    resources :partners

    match 'feats/list_by_category/:key' => 'feats#list_by_category'
    match 'rewards/list_by_category/:key' => 'rewards#list_by_category'
  end


  root :to => "welcome#index"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
