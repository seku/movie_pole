class AddTorrentsCountToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :torrents_count, :integer
  end

  def self.down
    remove_column :movies, :torrents_count, :integer
  end
end
