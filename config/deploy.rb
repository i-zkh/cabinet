set :rvm_ruby_string, 'default'
set :rvm_type, :user
 
server "54.214.239.57 ", :web, :app, :db, primary: true

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

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
	run "if [ -d #{current_path} ] && [ -f #{cw_pid_file} ]; then cd #{current_path} && kill -int $(cat #{cw_pid_file}) 2>/dev/null; else echo 'clockwork was not running' ; fi"
	run "cd #{current_path}; nohup bundle exec clockwork lib/clockwork.rb -e #{rails_env} >> #{current_path}/log/clockwork.log 2>&1 &", :pty => false
	run "ps -eo pid,command | grep clockwork | grep -v grep | awk '{print $1}' > #{cw_pid_file}"
  end
end