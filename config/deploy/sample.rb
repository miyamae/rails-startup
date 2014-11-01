server 'rails-startup.bitarts.jp',
  user: 'web',
  roles: %w{ app db }
set :rails_env, :production
set :deploy_to, '/var/www/rails-startup/production'
