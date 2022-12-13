# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "clinic"
set :repo_url, "git@github.com:safych/clinic.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/clinic"
set :rvm_ruby_version, "ruby-3.0.0"
set :default_env, { rvm_bin_path: "~/.rvm/bin" }

append :linked_files, 'config/master.key'

namespace :deploy do
  Rake::Task["migrate"].clear_actions
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end
end
