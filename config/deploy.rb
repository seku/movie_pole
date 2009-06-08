set :application, "trix"
set :repository,  "git://github.com/seku/movie_pole.git"
set :scm, :git
set :user, "trix"
#set :password, "trix"
set :use_sudo, false
set :domain, "trix.megiteam.pl"

set :deploy_to, "~/trix"

set :use_sudo, false


role :app, "trix.megiteam.pl"
role :web, "trix.megiteam.pl"
role :db,  "trix.megiteam.pl", :primary => true

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

