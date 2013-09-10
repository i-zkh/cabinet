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

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
  
after "deploy:stop", "clockwork:stop"
after "deploy:start", "clockwork:start"
after "deploy:restart", "clockwork:restart"
 
namespace :clockwork do
  desc "Stop clockwork"
  task :stop, :roles => clockwork_roles, :on_error => :continue, :on_no_matching_servers => :continue do
    run "if [ -d #{current_path} ] && [ -f #{pid_file} ]; then cd #{current_path} && kill -INT `cat #{pid
_file}` ; fi"
  end
 
  desc "Start clockwork"
  task :start, :roles => clockwork_roles, :on_no_matching_servers => :continue do
    run "daemon --inherit --name=clockwork --env='#{rails_env}' --output=#{log_file} --pidfile=#{pid_file
} -D #{current_path} -- bundle exec clockwork config/clockwork.rb"
  end
 
  desc "Restart clockwork"
  task :restart, :roles => clockwork_roles, :on_no_matching_servers => :continue do
    stop
    start
  end
 
  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end
 
  def log_file
    fetch(:clockwork_log_file, "#{current_path}/log/clockwork.log")
  end
 
  def pid_file
    fetch(:clockwork_pid_file, "#{current_path}/tmp/pids/clockwork.pid")
  end
end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end