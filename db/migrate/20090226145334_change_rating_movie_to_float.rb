class ChangeRatingMovieToFloat < ActiveRecord::Migration
  def self.up
  	change_column(:movies, :rating, :float)
  end

  def self.down
  	change_column(:movies, :rating, :integer)
  end
end
