class CreateGenresMovies < ActiveRecord::Migration
  def self.up
    create_table :genres_movies, :id => false do |t|
      t.references :genre, :movie, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :genres_movies
  end
end
