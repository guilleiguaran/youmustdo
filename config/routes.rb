ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)
  map.root :controller => 'home', :action => 'index'
  
  map.resources :musts do |must|
    must.resources :comments
    must.agree '/agree', :controller => 'agrees', :action => 'agree'
    must.disagree '/disagree', :controller => 'agrees', :action => 'disagree'
  end
  
  # Favorites
  map.favorites '/favorites', :controller => 'favorites', :action => 'index'
  map.favorite '/musts/:must_id/favorite', :controller => 'favorites', :action => 'create'
  map.unfavorite '/musts/:must_id/unfavorite', :controller => 'favorites', :action => 'destroy'
  
  # Other Routes
  map.privacy '/privacy', :controller => 'home', :action => 'privacy'
  map.terms '/terms', :controller => 'home', :action => 'terms'
  
  # User Routes
  map.user_profile     '/users/:id/profile', :controller => 'users', :action => 'profile'
  map.user_update_profile "/users/:id/update_profile", :controller => 'users', :action => 'update', :conditions => { :method => :put }

  # Must Routes
  map.get_url_metadata '/musts/get_url_metadata', :controller => 'musts', :action => 'get_url_metadata'
  
  # Follow/Unfollow
  map.followers '/followers', :controller => 'follows', :action => 'followers'
  map.followings '/followings', :controller => 'follows', :action => 'followings'
  map.follow '/follow/:user_id', :controller => 'follows', :action => 'follow'
  map.unfollow '/unfollow/:user_id', :controller => 'follows', :action => 'unfollow'

  
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
