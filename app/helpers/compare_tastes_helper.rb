module CompareTastesHelper

  def find_movie(id)
    Movie.find(id) 
  end
  
  def voted?(id)
    current_user_voted?(id) ? "" : "voted"
  end
  
  def rated?(id)
    current_user_voted?(id) ? nil : current_user.votes.find_by_movie_id(id).user_rating
  end
  
  def current_user_voted?(id)
    current_user.votes.find_by_movie_id(id).nil?
  end
  
end
