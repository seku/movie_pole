class Movie < ActiveRecord::Base 
  named_scope :most_voted, :order => "movies.votes desc"
  named_scope :rated_with, lambda { |rating| { :conditions => ["rating >= ?", rating] } }
  named_scope :only_torrents, :conditions => ["torrents_count > 0"]
  named_scope :sorted_by, lambda { |sort_by, sort_mode| {:order => "movies.#{sort_by} #{sort_mode}" } }
  #named_scope :title, :order => "movies.title asc"
  named_scope :limited, lambda { |num| { :limit => num } }

  before_validation :sanitize_title

  has_many :torrents
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :alerts
  
  serialize :directors, Array
  serialize :writers, Array 
  validates_presence_of :title, :imdb_id
  validates_uniqueness_of :imdb_id
  validates_numericality_of [:votes, :rating, :year], :allow_nil => true
  @full_info = IMDB::FullInformation.new
  @now_playing = IMDB::NowPlaying.new
  
  #sphinx search 
  define_index do
    # fields
    indexes title, :sortable => true
    indexes directors, :sortable => true
    indexes writers, :sortable => true
    # attributes
    has genres(:id), :as => :genre_ids
    has release_date, rating, torrents_count
    
  end
 
  def sanitize_title
    return unless title
    title.strip!
  end

  def self.fetch_movies
		@search_date = search_start_date
		while @search_date < today_date
  		current_week_movies(@search_date)
  		@search_date += 7
  	end
  end
  
  private
  
  def self.current_week_movies(date)
    ids = current_week_imdb_ids(date).reject{|id| Movie.find_by_id(id)}
    movies = ids.flatten.map {|id| @full_info.information(id)[:result] }
    bulk_save_movies(date, movies)
  end

  def self.current_week_imdb_ids(date)
    puts "..current_week_imdb_ids..#{date.to_s}"
    @now_playing.movies(date.year.to_i, date.month.to_i, date.day.to_i)[:results].map{|movie| movie[:imdb_id]}
  end

  def self.bulk_save_movies(date, movies = [])
    puts "..bulk_save_movies.."    
    movies.each do |m|
      new_movie = Movie.create!(
        :title => m[:title],
        :imdb_id => m[:imdb_id].to_i,
        :rating => m[:rating],
        :year => m[:year].to_i,
        :votes => m[:votes].to_i,
        :writers => m[:writers],
      	:directors => m[:directors],
      	:tagline => m[:tagline],
      	:plot => m[:plot],
      	:poster => m[:poster],
      	:official_site => m[:official_site],
      	:release_date => date)
      genres = Genre.all.map(&:name)
      Genre.first.movies << new_movie
      m[:genres].each do |genre| 
       if genres.include?(genre.underscore)
         new_movie.genres << Genre.find_by_name(genre.underscore)
       end
      end
    end    
  end
  
  
  # date must be the newest from database or if database is empty date =(2002,8,2)
  def self.search_start_date 
  	@start_date = Date.new(2008,10,10)
  end
  
	def self.today_date
		Date.today
	end
	
end


