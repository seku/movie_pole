ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "home", :action => "show"
  map.resources :movies
  
end
