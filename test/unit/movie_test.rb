require '../test_helper'

class MovieTest < ActiveSupport::TestCase
  fixtures :movies, :torrents, :genres

  context "Arguments" do
    setup do
      @movie = movies(:first_movie)
    end
    
    should "have correct title" do
      assert_equal "Quarantine", @movie.title
    end
    should "have correct imdb_id" do
      assert_match 1082868, @movie.imdb_id
    end
    should "have correct votes" do
      assert_in_delta 10520, @movie.votes, 10
    end
    should "have correct rating" do
      assert_equal 6.2, @movie.rating
    end
  end
  
  
  context "relationships" do
    setup do
      @movie = movies(:first_movie)
    end
    should_have_and_belong_to_many :alerts
    should_have_many :torrents
    should_have_and_belong_to_many :genres
    should_validate_uniqueness_of :imdb_id
    should_validate_presence_of :title
    should_validate_numericality_of :votes 
    should_validate_numericality_of :rating
    should_validate_numericality_of :year
    should_have_named_scope :most_voted, :order => "movies.votes desc"
    should_have_named_scope :only_torrents, :conditions => ["torrents_count > 0"]
    should_have_named_scope "rated_with(7.0)", :conditions => ["rating >= ?", 7.0]
    #should_have_named_scope "sorted_by(rating)", :order => "movies.rating desc"
  end
end
