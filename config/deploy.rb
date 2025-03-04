`ssh-add`
# config valid only for current version of Capistrano
lock '>=3.4.0'

set :application, 'im-here'
set :repo_url, 'git@bitbucket.org:smartboss/im-here.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/im-here'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push( 'config/database.yml', 
                                                  'config/secrets.yml', 
                                                  'config/facebook.yml', 
                                                  'config/shopify_webhook_secret.yml',
                                                  'config/shopify_here_order_action.yaml',
                                                  'config/domain_variables.yml' )

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :rails_env, fetch(:stage)

# Default value for keep_releases is 5
set :keep_releases, 5
set :passenger_restart_with_touch, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
