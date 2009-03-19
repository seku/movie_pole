class AddPosterToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :poster, :string
  end

  def self.down
    remove_column :movies, :poster
  end
end
