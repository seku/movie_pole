class RemoveGenreIdFromMovies < ActiveRecord::Migration
  def self.up
    remove_column :movies, :genre_id
  end

  def self.down
    add_column :movies, :genre_id, :integer
  end
end
