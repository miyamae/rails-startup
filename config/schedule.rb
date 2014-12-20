# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
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

set :output, 'log/cron.log'
set :environment, :production

# Session Expiry
every 1.day, at: '4:00 am' do
  runner 'Session.sweep(updated: 5.hour, created: 5.days)'
end

## Cleanup flushed cache
# every 1.day, at: '3:00 am' do
#   command 'if [ -e /tmp/flushed_cache.* ]; then ionice -c 2 -n 7 nice -n 19 rm -rf /tmp/flushed_cache.*; fi'
# end
