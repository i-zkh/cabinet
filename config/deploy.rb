require "rvm/capistrano"
require 'sidekiq/capistrano'

set :rvm_ruby_string, 'default'
set :rvm_type, :user
 
server "ec2-54-212-98-198.us-west-2.compute.amazonaws.com", :web, :app, :db, primary: true

set :application, "project"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

set :scm, "git"
set :repository, "git://github.com/ivannasya/vendor.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["/vagrant/project/aws.pem"]}

after 'deploy:update_code', 'deploy:symlink_uploads'
before "deploy:update_code", "sidekiq:quiet"
after "deploy:stop",    "sidekiq:stop"
after "deploy:start",   "sidekiq:start"
before "deploy:restart", "sidekiq:restart"


namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end


  namespace :sidekiq do    
    desc "Quiet sidekiq (stop accepting new work)"
    task :quiet, :roles => :app, :on_no_matching_servers => :continue do
      run "/usr/sbin/service sidekiq quiet"
    end

    desc "Stop sidekiq"
    task :stop, :roles => :app, :on_no_matching_servers => :continue do
      run "sudo /usr/bin/monit stop sidekiq"
    end

    desc "Start sidekiq"
    task :start, :roles => :app, :on_no_matching_servers => :continue do
      run "sudo /usr/bin/monit start sidekiq"
    end

    desc "Restart sidekiq"
    task :restart, :roles => :app, :on_no_matching_servers => :continue do
      run "sudo /usr/bin/monit restart sidekiq"
    end
  end  

end