server 'rails-startup.bitarts.co.jp',
  user: 'miyamae',
  roles: %w{web app db}
set :rails_env, :production
set :deploy_to, '/var/www/rails-startup/production'
