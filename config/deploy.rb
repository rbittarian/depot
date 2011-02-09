#---
# Excerpted from "Agile Web Development with Rails, 4rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# be sure to change these
set :user, 'devuser'
set :domain, 'samp.domain.com'
set :application, 'depot'

# file paths
set :repository,  "#{user}@#{domain}:/home/#{user}/git/#{application}.git" 
set :deploy_to, "/home/#{user}/Projects/rails/awdwr/#{application}" 

# distribute your applications across servers (the instructions below put them
# all on the same server, defined above as 'domain', adjust as necessary)
role :app, domain
role :web, domain
role :db, domain, :primary => true

# you might need to set this if you aren't seeing password prompts
default_run_options[:pty] = true

# As Capistrano executes in a non-interactive mode and therefore doesn't cause
# any of your shell profile scripts to be run, the following might be needed
# if (for example) you have locally installed gems or applications.  Note:
# this needs to contain the full values for the variables set, not simply
# the deltas.
# default_environment['PATH']='<your paths>:/usr/local/bin:/usr/bin:/bin'
# default_environment['GEM_PATH']='<your paths>:/usr/lib/ruby/gems/1.8'

# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do
  # cause Passenger to initiate a restart
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
   
  # reload the database with seed data
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end

# optional task to reconfigure databases
after "deploy:update_code", :bundle_install, :setdbconfig
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end  
 desc "copy database.yml from shared to current"
 task :setdbconfig do
   run "cp #{deploy_to}/shared/database.yml #{release_path}/config"
 end
