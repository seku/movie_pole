class AddArgsToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :genre, :string
    add_column :movies, :release_date, :date
    add_column :movies, :directors, :string
    add_column :movies, :writers, :string
    add_column :movies, :tagline, :text
    add_column :movies, :plot, :text
  end

  def self.down
    remove_column :movies, :plot
    remove_column :movies, :tagline
    remove_column :movies, :writers
    remove_column :movies, :directors
    remove_column :movies, :release_date
    remove_column :movies, :genre
  end
end
