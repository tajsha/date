Dating::Application.routes.draw do
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'edit' => 'users#edit'
  get "/profile/:id" => "users#show"
  get "profile/:id/settings" => 'users#edit'
  get 'settings/:id' => 'users#settings'
  get 'letsgos/eatdrink' => 'letsgos#eatdrink'
  get 'letsgos/listenwatch' => 'letsgos#listenwatch'
  get 'letsgos/play' => 'letsgos#play'
  get 'letsgos/other' => 'letsgos#other'
  get 'letsgos/explore' => 'letsgos#explore'
  
  resources :sessions
  resources :password_resets
  resources :galleries
  resources :photos
  resources :searches
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :letsgos, only: [:create, :destroy]
  resources :users do  
    get 'settings', on: :member  
    post 'follow', on: :member 
    post 'unfollow', on: :member
    get "follow", on: :member 
  end
  
  resources :letsgos do
    member do
      post :repost
      post :interested
    end
  end
  
  resources :questions do
    resources :answers, only: [:new, :create]
  end
  
  resources :orders do
    collection do
      get :paid
      get :revoked
      post :ipn
    end
  end
  
  root to: 'users#new'
  
  resources :users do |user|

    resources :messages do
      collection do
        post 'delete_multiple'
        get 'askout', action: 'askout'
        get 'reply', action: 'reply'
      end
    end
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
