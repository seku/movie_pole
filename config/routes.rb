ActionController::Routing::Routes.draw do |map|
  map.resources :alerts
  map.resources :orders
  map.resource :account, :controller => "users"
  map.resource :user_session
  map.resources :users, :has_one => :photo, :has_many => :weekly_alerts, :collection => { :set_subtitles_language => :get, :desired_movies => :get }
  map.root :controller => "genres", :action => "index"
  map.resources :movies, :collection => {:fetch => :get, :rss => :get, :fusers_votes => :get }
  map.resources :genres, :has_many => :movies
  map.resources :searches, :collection => { :autocomplete => :get, :suggest => :get }
  map.resources :login_emails
  map.resources :alerts_emails
  map.resources :desirable_alerts
  map.resources :weekly_alerts
  map.resources :comments, :collection => { :sending => :get }
  map.resources :votes
  map.resources :compare_tastes, :collection => {:find_closest_users => :get, :compared_user_votes => :get }
  map.resources :followings
end
