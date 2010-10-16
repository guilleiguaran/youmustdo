ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)
  map.root :controller => 'home', :action => 'index'
  map.resources :musts do |must|
    must.resources :comments
  end
  
end
