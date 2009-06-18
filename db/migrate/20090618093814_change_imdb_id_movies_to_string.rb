class ChangeImdbIdMoviesToString < ActiveRecord::Migration
  def self.up
    change_column(:movies, :imdb_id, :string)
  end
  
  def self.down
    change_column(:movies, :imdb_id, :integer) 
  end
end
