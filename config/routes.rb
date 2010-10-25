YouMustDo::Application.routes.draw do
  
  # User & Clearance Routes
  # ==========================================================================================
  match '/sign_in', :to => 'sessions#new', :as => "sign_in"
  match '/sign_out', :to => 'sessions#destroy', :via => :delete, :as => 'sign_out'
  match '/sign_up'  => 'users#new', :as => 'sign_up'
  resource  :session, :controller => 'sessions', :only => [:new, :create, :destroy]
  resources :passwords, :controller => 'passwords', :only => [:new, :create]
  resources :users, :controller => 'users', :only => [:new, :create] do
    resource :password, :controller => 'passwords', :only => [:create, :edit, :update]
    resource :confirmation, :controller => 'clearance/confirmations', :only => [:new, :create]
    member do
      get :profile
      put :update_profile
    end
  end
  
  
  # Sections Routes
  # ==========================================================================================
  root :to => 'home#index'
  match '/musts/me', :to => 'musts#my_musts', :as => 'my_musts'
  match '/u/:username', :to => 'musts#user_musts', :as => 'user_musts'
  match '/tags/:tag', :to => 'musts#tags', :as => 'tags'
  match '/recents', :to => 'musts#recents', :as => 'recents'
  match '/favorites', :to => 'favorites#index', :as => 'favorites'
  match '/privacy', :to => 'home#privacy', :as => 'privacy'
  match '/terms', :to => 'home#terms', :as => 'terms'
  match '/about', :to => 'home#about', :as => 'about'


  # Musts Routes
  # ==========================================================================================
  resources :musts do
    resources :comments
    match '/agree', :to => 'agrees#agree', :as => 'agree'
    match '/disagree', :to => 'agrees#disagree', :as => 'disagree'
    match '/favorite', :to => 'favorites#favorite', :as => 'favorite'
    match '/unfavorite', :to => 'favorites#unfavorite', :as => 'unfavorite'
  end
  match '/musts/get_url_metadata', :to => 'musts#get_url_metadata', :as => 'get_url_metadata'


  # Bucket List Routes
  # ==========================================================================================
  match '/users/:id/bucket_list', :to => 'buckets#index', :via => :get, :as => 'buckets'
  match '/users/:id/buckets', :to => 'buckets#create', :via => :post, :as => 'create_bucket'
  match '/users/:id/buckets', :to => 'buckets#destroy', :via => :delete, :as => 'create_bucket'
  match '/users/:id/bucket_done', :to => 'buckets#update', :via => :put, :as => 'update_bucket'



  # Follow/Unfollow
  # ==========================================================================================
  match '/followers', :to => 'follows#followers', :as => 'followers'
  match '/followings', :to => 'follows#followings', :as => 'followings'
  match '/follow/:user_id', :to => 'follows#follow', :as => 'follow'
  match '/ufollow/:user_id', :to => 'follows#unfollow', :as => 'unfollow'
  

  # Routes for social networks
  # ==========================================================================================
  # Facebook
  match '/facebook/auth', :to => 'facebook/sessions#new', :as => 'facebook_auth'
  match '/facebook/connect', :to => 'facebook/sessions#create', :as => 'facebook_connect'
  namespace :facebook do
    resource :users, :only => [:new, :create]
  end
  # Twitter
  match '/twitter/login', :to => 'twitter/sessions#create', :as => 'twitter_login'
  match '/twitter/connect', :to => 'twitter/sessions#connect', :as => 'twitter_session'
  namespace :twitter do
    resource :users, :only => [:new, :create]
  end


  # Routes for searching
  # ==========================================================================================
  resources :search, :only => [:index]
  
  
  # Routes for categories
  # ==========================================================================================
  match '/:category', :to => 'categories#show', :as => 'categories'
end
