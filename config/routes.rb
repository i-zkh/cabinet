Project::Application.routes.draw do

  resources :vendors
  resources :transactions
  resources :sessions
  resources :counters
  resources :address_ranges

  root :to => "transactions#index"

  get 'get_key' => "key#create"

  get 'address_range' => "user_check#address"
  get 'user_account' => "user_check#account"

  get 'work_counters' => "counters#work_counters"
  
# Report
  get 'get_payment' => 'payments#create'

# Parsing report
  get 'get_txt' => 'txt#create'
  get 'get_xls' => 'xls#create'
  get 'get_xlt' => 'address_ranges#create'

  get 'add_vendor_to_service' => 'request#add_vendor_to_service'
  get 'create_field_template' => 'request#request_field_template'
  get 'create_tariff_template' => 'request#request_tariff_template'
  get 'get_vendor' => 'request#get_vendor'
  
# Organization file
  get 'add_organization' => 'organization#all'
  get 'add_absense_vendor' => 'organization#absence'

# Precinct
  get 'ovd' => 'ovd#ovd'

# Jiguli
  get 'osmp' => 'request#osmp'

end
