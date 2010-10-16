ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)
  map.root :controller => 'home', :action => 'index'
  
  map.resources :musts do |must|
    must.resources :comments
    must.agree '/agree', :controller => 'agrees', :action => 'agree'
    must.disagree '/disagree', :controller => 'agrees', :action => 'disagree'
  end
  
  # User Routes
  map.user_profile     '/users/:id/profile', :controller => 'users', :action => 'profile'
  map.user_update_profile "/users/:id/update_profile", :controller => 'users', :action => 'update', :conditions => { :method => :put }

  map.get_url_metadata '/musts/get_url_metadata', :controller => 'musts', :action => 'get_url_metadata'

  
  # Routes for social networks
  # ==================================================================================================
  # Facebook
  map.facebook_auth     '/facebook/auth',       :controller => 'facebook/sessions', :action => 'new'
  map.facebook_connect  '/facebook/connect',    :controller => 'facebook/sessions', :action => 'create'
  map.namespace :facebook do |facebook|
    facebook.resource :users, :only => [:new, :create]
  end
  # Twitter
  map.twitter_login   '/twitter/login',     :controller => 'twitter/sessions',  :action => 'create'
  map.twitter_session '/twitter/connect',   :controller => 'twitter/sessions',  :action => 'connect'
  map.namespace :twitter do |twitter|
    twitter.resource :users, :only => [:new, :create]
  end
  # ==================================================================================================
  #map.resources :categories, :only => [:show]
  map.categories '/:category', :controller => 'categories', :action => 'show'
end
