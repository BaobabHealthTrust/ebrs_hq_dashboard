require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
#set :path, Rails.root
#set :output, 'log/cron.log'
env :PATH, ENV['PATH']

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
env :PATH, ENV['PATH']
set :output, "log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


every 2.hours do
  rake "ebrs:dashboard!"
end

every :reboot do
	rake "dashboard:dashboard_files"
end

every 10.minutes do
  rake "dashboard:stats"
end

every 5.minutes do
 	rake "dashboard:dashboard_files"
end
