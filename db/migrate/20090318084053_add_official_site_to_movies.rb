class AddOfficialSiteToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :official_site, :string
  end

  def self.down
    remove_column :movies, :official_site
  end
end
