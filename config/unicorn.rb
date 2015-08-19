app_root = File.expand_path('../../', __FILE__)

worker_processes ENV['unicorn_worker_process'] || 5
working_directory app_root

listen "#{app_root}/tmp/sockets/unicorn.sock", backlog: 64
pid "#{app_root}/tmp/pids/unicorn.pid"

stdout_path "#{app_root}/log/unicorn_access.log"
stderr_path "#{app_root}/log/unicorn_error.log"
