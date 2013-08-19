Project::Application.routes.draw do

  resources :vendors
  resources :transactions
  resources :sessions
  resources :counters

  get 'get_key' => "key#create"
  get 'transactions' =>  "transactions#index"
  get 'address_range' => "user_check#address"
  get 'user_account' => "user_check#account"
  get 'get_payment' => 'payments#create'
  get 'get_txt' => 'txt#create'
  get 'get_xls' => 'xls#create'
  get 'get_xlt' => 'address_ranges#create'
  
  get 'auth' => 'auth_token#create'

  #Post request
  get 'create_vendor' => 'request#request_vendor'
  get 'create_field_template' => 'request#request_field_template'
  get 'create_tariff_template' => 'request#request_tariff_template'

  #match 'payments' => 'payments#show', :as => 'payments', :via => :get
  #match 'payments' => 'payments#create', :as => 'payments', :via => :post

  #match 'contact' => 'contact#new', :as => 'contact', :via => :get
  #match 'contact' => 'contact#create', :as => 'contact', :via => :post

  root :to => "transactions#index"
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
