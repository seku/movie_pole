class Vote < ActiveRecord::Base
  named_scope :rated_with, lambda {|rating| { :conditions => ["user_rating <= ? AND user_rating >= ?", rating + 2, rating - 2] } }
  named_scope :on_movie, lambda {|movie_id| { :conditions => ["movie_id = ?", movie_id] } }
  belongs_to :user
  belongs_to :movie
  validates_uniqueness_of :movie_id, :scope => :user_id
end
