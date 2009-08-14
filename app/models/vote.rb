class Vote < ActiveRecord::Base
  include MoviesHelper
  named_scope :rated_with, lambda {|rating| { :conditions => ["user_rating <= ? AND user_rating >= ?", rating + 2, rating - 2] } }
  named_scope :on_movie, lambda {|movie_id| { :conditions => ["movie_id = ?", movie_id] } }
  belongs_to :user
  belongs_to :movie
  validates_uniqueness_of :movie_id, :scope => :user_id

  
  def self.analize_votes(movie_id, rating, current_user)
    @votes = Vote.on_movie(movie_id).rated_with(rating.to_i).reject{|v| v.user_id == current_user.id}
    unless @votes.empty?
      @users_array = []
      @votes.each do |vote|
        @user = vote.user
        @users_array << {:user_id => @user.id, :user => @user.login, :comparison_value => check_user(@user, current_user), :rating => Vote.on_movie(movie_id).find_by_user_id(@user.id).user_rating, :gravatar => @user.gravatar_url(:default => "wavatar", :size => 30), :followed_user => followed_user?(@user, current_user)}
      end
    end
    @users_array
  end
  
  def self.followed_user?(user, current_user)
    current_user.followed_users.include? user
  end
  
  def self.check_user(user, current_user)
    @movie_ids = []
    current_user.votes.each {|vote| @movie_ids << vote.movie_id}
    user.votes.each do |vote|
      unless @movie_ids.include? vote.movie_id
        @movie_ids << vote.movie_id
      end
    end
    @comparison = check_taste(@movie_ids, user, current_user)  
    (@comparison > 100) ? 100 : @comparison
  end

  def self.check_taste(movie_ids, compared_user, current_user)
    unless movie_ids.empty?
      @sum = 0
      movie_ids.each do |movie_id|
        if current_user.votes.find_by_movie_id(movie_id) && compared_user.votes.find_by_movie_id(movie_id)
          @sum += 17 - (compared_user.votes.find_by_movie_id(movie_id).user_rating - current_user.votes.find_by_movie_id(movie_id).user_rating).abs
        end 
      end
      round_comparison(@sum * 100 / (movie_ids.size * 10).to_f)
    else
      0
    end 
  end
  
  def self.round_comparison(comparison)
    (comparison * 100).round.to_f / 100
  end

end
