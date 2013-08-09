require './lib/clock'
require './lib/scheduler'
 
# Connecting to Redis vias Socket is 10-20% faster than TCP
if ENV["REDISTOGO_URL"]
  url = ENV["REDISTOGO_URL"]
elsif File.exist? '/usr/local/var/run/redis.sock'
  url = 'unix:/usr/local/var/run/redis.sock'
elsif File.exist? '/var/run/redis/redis.sock'
  url = 'unix:/var/run/redis/redis.sock'
else
  url = 'redis://127.0.0.1:6379'
end
 
Sidekiq.configure_server do |config|
  config.redis = { namespace: 'mynamespace', url: url }
  AwesomeRailsApp::ClockworkScheduler.new.run!
end
 
Sidekiq.configure_client do |config|
  config.redis = { namespace: 'mynamespace', size: 10, url: url }
end