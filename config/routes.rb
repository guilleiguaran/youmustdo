ActionController::Routing::Routes.draw do |map|
  map.resource  :session,   :controller => 'sessions',  :only => [:new, :create, :destroy]
  map.sign_in  'sign_in',   :controller => 'sessions',  :action => 'new'
  map.sign_out 'sign_out',  :controller => 'sessions',  :action => 'destroy', :method => :delete
  map.sign_up  'sign_up',   :controller => 'users',     :action => 'new'

  map.resources :passwords, :controller => 'passwords', :only => [:new, :create]
  map.resource  :session,   :controller => 'sessions',  :only => [:new, :create, :destroy]
  map.resources :users,     :controller => 'users' do |users|
    users.resource :password,     :controller => 'passwords', :only => [:create, :edit, :update]
    users.resource :confirmation, :controller => 'clearance/confirmations', :only => [:new, :create]
  end

  Clearance::Routes.draw(map)
  map.root :controller => 'home', :action => 'index'
  map.my_musts '/musts/me', :controller => 'musts', :action => 'my_musts'
  map.tags '/tags/:tag', :controller => 'musts', :action => 'tags'
  map.recents '/recents', :controller => 'musts', :action => 'recents'
  
  map.resources :musts do |must|
    must.resources :comments
    must.agree '/agree', :controller => 'agrees', :action => 'agree'
    must.disagree '/disagree', :controller => 'agrees', :action => 'disagree'
  end
  
  # Must Routes
  map.get_url_metadata '/musts/get_url_metadata', :controller => 'musts', :action => 'get_url_metadata'
  

  # Favorites
  map.favorites '/favorites', :controller => 'favorites', :action => 'index'
  map.favorite '/musts/:must_id/favorite', :controller => 'favorites', :action => 'favorite'
  map.unfavorite '/musts/:must_id/unfavorite', :controller => 'favorites', :action => 'unfavorite'

  map.load_more_must '/musts/load_more/:date', :controller => 'musts', :action => 'load_more'

  
  # Bucket List
  map.buckets '/users/:id/bucket_list', :controller => 'buckets', :action => 'index', :conditions => { :method => :get }
  map.create_bucket '/users/:id/buckets', :controller => 'buckets', :action => 'create', :conditions => { :method => :post }
  map.create_bucket '/users/:id/buckets', :controller => 'buckets', :action => 'destroy', :conditions => { :method => :delete }
  map.update_bucket '/users/:id/bucket_done', :controller => 'buckets', :action => 'update', :conditions => { :method => :put }

  
  # Other Routes
  map.privacy '/privacy', :controller => 'home', :action => 'privacy'
  map.terms '/terms', :controller => 'home', :action => 'terms'
  map.about '/about', :controller => 'home', :action => '  map.terms '/terms', :controller => 'home', :action => 'terms'
'
  
  # User Routes
  map.user_profile     '/users/:id/profile', :controller => 'users', :action => 'profile'
  map.user_update_profile "/users/:id/update_profile", :controller => 'users', :action => 'update', :conditions => { :method => :put }
  
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
  
  map.resources :search, :only => [:index]
  
  map.categories '/:category', :controller => 'categories', :action => 'show'
  map.user_musts '/u/:username', :controller => 'musts', :action => 'user_musts'
end
