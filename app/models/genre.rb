class Genre < ActiveRecord::Base
  
  has_and_belongs_to_many :movies
  validates_uniqueness_of :name
  
  def self.fetch_genres
    @genre = Genre.available
    @genre.each{|genre| Genre.create!(:name => genre)}
  end
  
  def self.available
    ["All", "Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "Game-Show", "History", "Horror", "Music", "Musical", "Mystery", "News", "Reality-TV", "Romance", "Sci-Fi", "Short", "Sport", "Talk-Show", "Thriller", "War", "Western"].map { |g| g.underscore }
  end
  
  def self.options_for_select
    find(:all).map{ |g| [I18n.translate("genres.#{g.name}"), g.id] }
  end
  
end
