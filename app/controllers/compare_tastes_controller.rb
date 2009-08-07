class CompareTastesController < ApplicationController
  
  def show
    @movie_ids = []
    current_user.votes.each {|vote| @movie_ids << vote.movie_id}
    @compared_user = User.find(params[:id])
    @compared_user.votes.each do |vote|
      unless @movie_ids.include? vote.movie_id
        @movie_ids << vote.movie_id
      end
    end
    @comparison = check_taste(@movie_ids, @compared_user)  
  end

  def check_taste(movie_ids, compared_user)
    unless movie_ids.empty?
      @sum = 0
      movie_ids.each do |movie_id|
        if current_user.votes.find_by_movie_id(movie_id) && compared_user.votes.find_by_movie_id(movie_id)
          @sum += 10 - (compared_user.votes.find_by_movie_id(movie_id).user_rating - current_user.votes.find_by_movie_id(movie_id).user_rating).abs
        end 
      end
      @sum * 100 / (movie_ids.size * 10).to_f
    else
      0
    end 
  end
end
