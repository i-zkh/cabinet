Project::Application.routes.draw do

  resources :vendors
  resources :transactions
  resources :counters
  resources :address_ranges
  resources :sessions

  root :to => "transactions#index"

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'user_account' => 'user_accounts#index'
  get 'get_key' => "key#create"

  get 'energosbyt' => 'energosbyt#index'
  get 'energosbyt/create' => 'energosbyt#create'
  
  # get 'address_range' => "user_check#address"
  # get 'user_account' => "user_check#account"
  
# Report
  get 'get_payment' => 'payments#create'

# Parsing vendor's reports
  get 'accounts/create' => 'accounts#create'

  get 'get_xls' => 'xls#create'
  get 'get_xlt' => 'address_ranges#create'

  get 'add_vendor_to_service' => 'request#add_vendor_to_service'
  get 'create_field_template' => 'request#request_field_template'
  get 'create_tariff_template' => 'request#request_tariff_template'
  get 'get_vendor' => 'request#get_vendor'
  
# Organization file
  get 'organization/all' => 'organization#all'
  get 'add_absense_vendor' => 'organization#absence'

# Precinct
  get 'ovd' => 'ovd#ovd'

# Jiguli
  get 'osmp' => 'request#osmp'

end
