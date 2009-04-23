class AlertsMovies < ActiveRecord::Migration
  def self.up
    create_table :alerts_movies, :id => false do |t| 
      t.references :alert, :movie, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :alerts_movies
  end
end
