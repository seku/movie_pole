set :application, "trix"
set :repository,  "git://github.com/seku/movie_pole.git"
set :scm, :git
set :user, "trix"
#set :password, "trix"
set :use_sudo, false



# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "~/trix"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
#ssh_options[:keys] = %w(~/.ssh/id_rsa)

role :app, "trix.megiteam.pl"
role :web, "trix.megiteam.pl"
role :db,  "trix.megiteam.pl", :primary => true
