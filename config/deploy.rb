set :application, "auke.us"
set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/srv/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :repository, "git@github.com:beer/auke.git"
#set :scm_passphrase, ""

set :user, "beer"
set :use_sudo, false

#role :app, "maid.pivmi.info"
role :web, "maid.pivmi.info"
#role :db,  "your db-server here", :primary => true

## multi-stage deploy process ##

task :dev do
  role :web, "maid.pivmi.info", :primary => true
  set :deploy_to, "/srv/www/#{application}/dev"
end

task :staging do
  role :web, "maid.pivmi.info", :primary => true
  set :deploy_to, "/srv/www/#{application}/staging"
end

task :production do
  role :web, "maid.pivmi.info", :primary => true
  set :deploy_to, "/srv/www/#{application}"
end

namespace :deploy do

  task :finalize_update, :except => { :no_release => true } do
    transaction do
      run "chmod -R g+w #{releases_path}/#{release_name}"
    end
  end

  task :migrate do
    # do nothing
  end

  task :restart, :except => { :no_release => true } do
    #run "sudo service nginx reload"
  end

  after "deploy", :except => { :no_release => true } do
    #run "cd #{releases_path}/#{release_name} && phing spawn-workers > /dev/null 2>&1 &", :pty => false
  end
end
