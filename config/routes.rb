ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "genres", :action => "index"
  map.resources :movies, :collection => {:fetch => :get, :rss => :get }
  map.resources :genres, :has_many => :movies
  map.resources :searches
end
