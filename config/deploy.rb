set :application, "trix"
set :repository,  "git://github.com/seku/movie_pole.git"
set :scm, :git
set :user, "trix"
set :use_sudo, false
set :deploy_to, "~/trix"
set :use_sudo, false

set :rails_env, "production"

server "trix.megiteam.pl", :app, :web, :db, :primary => true 

namespace :deploy do
  desc "Restart app"
    task :restart, :role => :app do
    run "restart-app #{application}"
  end
  
  task :before_update do
  #  # Stop Thinking Sphinx before the update so it finds its configuration file.
    thinking_sphinx.stop
  end

  task :after_update do
    #symlink_sphinx_indexes
    thinking_sphinx.index
    thinking_sphinx.start
  end

  desc "Link up Sphinx's indexes."
  task :symlink_sphinx_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{current_path}/db/sphinx"
  end
  
end

namespace :db do
  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
  
end

task :symlink_sphinx_files do
  run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml" 
end

namespace :thinking_sphinx do
  task :configure, :roles => [:app] do
    run "cd #{current_path}; rake thinking_sphinx:configure RAILS_ENV=#{rails_env}"
  end
  task :index, :roles => [:app] do
    run "cd #{current_path}; rake thinking_sphinx:index RAILS_ENV=#{rails_env}"
  end
  task :start, :roles => [:app] do
    run "cd #{current_path}; rake thinking_sphinx:start RAILS_ENV=#{rails_env}"
  end
  task :stop, :roles => [:app] do
    run "cd #{current_path}; rake thinking_sphinx:stop RAILS_ENV=#{rails_env}"
  end
  task :restart, :roles => [:app] do
    run "cd #{current_path}; rake thinking_sphinx:restart RAILS_ENV=#{rails_env}"
  end
end


after "deploy:update_code", "symlink_sphinx_files"
after :deploy, "deploy:restart"
after "deploy:update_code", "db:symlink"




