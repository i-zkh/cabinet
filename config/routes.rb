Project::Application.routes.draw do

  get "manager/index"

  resources :vendors
  resources :transactions
  resources :counters
  resources :address_ranges
  resources :sessions

  root :to => "transactions#index"

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'get_key' => "key#create"

# Energosbyt
  get 'energosbyt' => 'energosbyt#index'
  post 'energosbyt' => 'energosbyt#create'
  get 'energosbyt_report' => 'energosbyt#xls'

# Server can check user's data
  get 'address_range' => "user_check#address"
  get 'user_account' => "user_check#account"
  
# Report
  get 'get_payment' => 'payments#create'
  get 'report/monthly/xls' => 'payments#monthly_xls'
  get 'report/monthly/txt' => 'payments#monthly_txt'
  get 'report/hourly' => 'payments#hourly'
  
# Parsing vendor's reports
  get 'accounts/create' => 'accounts#create'
  get 'accounts/update' => 'accounts#update'

  get 'get_xls' => 'xls#create'
  get 'get_xlt' => 'address_ranges#create'

  get 'add_vendor_to_service' => 'request#add_vendor_to_service'
  get 'create_field_template' => 'request#request_field_template'
  get 'create_tariff_template' => 'request#request_tariff_template'
  get 'get_vendor' => 'request#get_vendor'
  
# Add vendors fron Organizations
  get 'organization/add_vendors' => 'organization#add_vendors'
  get 'organization/auth_keys' => 'organization#auth_keys'

# Precinct
  get 'ovd' => 'ovd#ovd'
  get 'ovd_report' => 'ovd#xls'

# Jiguli
  get 'osmp' => 'request#osmp'

# Interface for managers
  get 'manager/report' => 'manager#index'
  post 'manager' => 'manager#import'

end
