set :application, 'SampleApp'
set :repo_url, 'https://github.com/miyamae/rails-startup.git'
set :branch, 'master'
set :rbenv_type, :system
set :rbenv_ruby, '2.2.1'
set :keep_releases, 5
set :bundle_path, -> { shared_path.join('vendor/bundle') }
set :linked_files, %w{ config/application.yml config/newrelic.yml }
set :linked_dirs, %w{ log tmp vendor/bundle public/system }
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  # init task
  desc 'Upload configuration files. not overwrite'
  task :upload_config do
    on roles(:app) do |host|
      if test("[ ! -d #{shared_path}/config ]")
        execute("mkdir -p #{shared_path}/config")
      end

      if test("[ ! -e #{shared_path}/config/database.yml ]")
        upload!('config/database.yml', "#{shared_path}/config/database.yml")
      end

      if test("[ ! -e #{shared_path}/config/application.yml ]")
        upload!('config/application.yml', "#{shared_path}/config/application.yml")
      end

      if test("[ ! -e #{shared_path}/config/newrelic.yml ]")
        upload!('config/newrelic.yml.sample', "#{shared_path}/config/newrelic.yml")
      end
    end
  end

  desc 'Create Database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:create'
      end
      end
    end
  end

  # auto task
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  task :assets_precompile do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within release_path do
        with rails_env: :production do
          execute :rake, 'assets:precompile'
        end
      end
    end
  end
  task :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'tmp:cache:clear'
          execute :rake, 'cache:clear'
        end
      end
    end
  end

  before :starting, :upload_config
  before 'deploy:migrate', :db_create
  after :publishing, :assets_precompile
  after :assets_precompile, :restart
  after :restart, :clear_cache

end
