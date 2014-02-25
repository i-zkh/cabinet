set :rvm_ruby_string, 'default'
set :rvm_type, :user
 
server "54.214.239.57 ", :web, :app, :db, primary: true

set :application, "project"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git://github.com/ivannasya/vendor.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["/vagrant/project/aws.pem"]}
 
set :clockwork_roles, :app
set :cw_log_file, "#{current_path}/log/clockwork.log"
set :cw_pid_file, "#{current_path}/tmp/pids/clockwork.pid"
set :rails_env, "production"

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :clockwork do
  desc "Stop clockwork"
  task :stop, :roles => clockwork_roles, :on_error => :continue, :on_no_matching_servers => :continue do
  run "ps -ef | grep PROCESS | grep -v grep | awk '{print $2}' | xargs kill -9"
  end
 
  desc "Start clockwork"
  task :start, :roles => clockwork_roles, :on_no_matching_servers => :continue do
	run "cd #{current_path}/lib; RAILS_ENV=#{rails_env} clockworkd -c clock.rb start >> #{current_path}/log/clockwork.log 2>&1 &", :pty => false
    # get process id
    run "ps -eo pid,command | grep clockwork | grep -v grep | awk '{print $1}' > #{cw_pid_file}"
  end
 
  desc "Restart clockwork"
  task :restart, :roles => clockwork_roles, :on_no_matching_servers => :continue do
    stop
    start
  end
end

after "deploy:restart", "clockwork:restart"
