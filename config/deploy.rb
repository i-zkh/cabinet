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
 
set :clockwork_roles, :blabla
set :cw_log_file, "#{current_path}/log/clockwork.log"
set :cw_pid_file, "#{current_path}/tmp/pids/clockwork.pid"
set :rails_env, ENV['rails_env'] || ''

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end