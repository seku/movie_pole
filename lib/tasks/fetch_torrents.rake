namespace :fetch do  
	task :prepare => :environment do
    puts "..require dependencies.."
    Dir.glob(File.join( RAILS_ROOT, 'app', 'models', '*.rb')).each { |file| require_dependency file }
    puts "..load Mininova.."
    @torrent = Mininova.new
  end

  desc 'Fetch torrents'
  task :torrents => :prepare do
    fetch_torrents
  end
	

end

