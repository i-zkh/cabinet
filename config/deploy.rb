require "bundler/capistrano"

server "ec2-54-245-165-167.us-west-2.compute.amazonaws.com", :web, :app, :db, primary: true

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

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
    run "cd #{current_path} && bin/bundle exec clockwork lib/clock.rb"
  end

end