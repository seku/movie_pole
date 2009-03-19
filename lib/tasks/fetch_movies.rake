namespace :fetch do  

  task :prepare => :environment do
    puts "..require dependencies.."
    Dir.glob(File.join( RAILS_ROOT, 'app', 'models', '*.rb')).each { |file| require_dependency file }
    puts "..load IMDB.."
    @full_info = IMDB::FullInformation.new
    @now_playing = IMDB::NowPlaying.new
  end

  desc 'Fetch movies seku'
  task :movies => :prepare do
    fetch_movies
	end
	

end




















