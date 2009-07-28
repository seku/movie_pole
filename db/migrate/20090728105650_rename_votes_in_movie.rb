class RenameVotesInMovie < ActiveRecord::Migration
  def self.up
    rename_column :movies, :votes, :imdb_votes
  end

  def self.down
    rename_column :movies, :imdb_votes, :votes
  end
end
