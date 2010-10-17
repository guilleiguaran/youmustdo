set :domain, "youmustdo.r10.railsrumble.com"
set :application, "youmustdo"
set :deploy_to, "/var/www/apps/#{application}"
set :user, "www-data"
set :runner, user
set :admin_runner, user
set :app_server, :passenger
set :rails_env, "production"
set :keep_releases, 5

set :scm, :git
set :branch, "master"
set :repository, "git@github.com:railsrumble/rr10-team-167.git"
set :deploy_via, :remote_cache


role :web, domain
role :app, domain
role :db, domain, :primary => true


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --set environment=production && whenever --update-crontab #{application}"
  end
end

after :deploy, "deploy:restart", "deploy:update_crontab"