require 'thinking_sphinx/deploy/capistrano' 

set :application, "trix"
set :repository,  "git://github.com/seku/movie_pole.git"
set :scm, :git
set :user, "trix"
#set :password, "trix"
set :use_sudo, false
set :deploy_to, "~/trix"

set :use_sudo, false


server "trix.megiteam.pl", :app, :web, :db, :primary => true 

namespace :deploy do
  desc "Restart app"
    task :restart, :role => :app do
    run "restart-app #{application}"
  end
end

namespace :db do
  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
end

after :deploy, "deploy:restart"
after "deploy:update_code", "db:symlink"

after "deploy:setup", "thinking_sphinx:shared_sphinx_folder"

