class AddMovieIdToAlert < ActiveRecord::Migration
  def self.up
    add_column :alerts, :movie_id, :integer
  end

  def self.down
    remove_column :alerts, :movie_id
  end
end
