server '127.0.0.1', port: 2222,
  user: 'vagrant',
  roles: %w{web app db},
  ssh_options: {
    user: 'vagrant',
    keys: %w(~/.vagrant.d/insecure_private_key),
    auth_methods: %w(publickey)
  }

set :rails_env, :production
set :deploy_to, '/home/vagrant/sampleapp/production'
