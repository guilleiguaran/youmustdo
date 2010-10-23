set :domain, "new.youmustdo.com"
set :application, "youmustdo.com"
set :deploy_to, "/var/www/apps/#{application}"
set :user, "www-data"
set :runner, user
set :admin_runner, user
set :rails_env, "production"

set :scm, :git
set :branch, "master"
set :repository, "git@github.com:youmustdo/youmustdo.com.git"
set :deploy_via, :remote_cache

set :unicorn_binary, "/usr/local/bin/unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"


role :web, domain
role :app, domain
role :db, domain, :primary => true


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  desc "Deploy the MFer"
  task :default do
    update
    restart
    cleanup
  end

  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    run "git clone #{repository} #{current_path}"
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
  end

  desc "Rollback a single commit."
  task :rollback, :except => { :no_release => true } do
    set :branch, "HEAD^"
    default
  end
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && sudo #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "sudo kill `cat #{unicorn_pid}` && rm -f #{unicorn_pid}"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "sudo kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "sudo kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
  task :symlink_shared do
     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --set environment=production && whenever --update-crontab #{application}"
  end
end

after :deploy, "deploy:restart", "deploy:update_crontab"