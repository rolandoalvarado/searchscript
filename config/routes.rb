SearchScript::Application.routes.draw do
  
  resources :locations
  #resources :users
  
  # Session
  match '/login', :to => 'session#new', :as => 'login', :via => [:get, :post]
  match '/logout', :to => 'session#logout', :as => 'logout', :via => :post
  match '/session/create', :to => 'session#create', :as => 'login_user', :via => :post
  
  # Users
  match '/users/new', :to => 'users#new', :as => 'new_user', :via => :post
  match '/users/create', :to => 'users#create', :as => 'create_user', :via => :post

  match '/users/new_merchant', :to => 'users#new_merchant', :as => 'new_merchant', 
                          :via => :post
  match '/users/create_merchant', :to => 'users#create_merchant', :as => 'create_merchant',
                          :via => :post
  
  # Locations
  match '/locations/:search', :to => 'locations#show_mechanic', :as => 'show_mechanic',
                          :via => :get
  
  match '/merhant_login', :to => 'session#new_merchant', :as => 'merchant_login', 
                          :via => :get
  match '/users/search_mechanic', :to => 'users#search_mechanic', :as => 'search_mechanic',
                                  :via => :post
  
  match '/pages/learn_more', :to => 'pages#learn_more', :as => 'learn_more',
                             :via => :get
  
  #match '/yelp', :to => 'site#yelp', :as => 'yelp', :via => :get
  #match '/yelp2', :to => 'site#yelp2', :as => 'yelp2', :via => :get
  
  root 'site#index'
end
