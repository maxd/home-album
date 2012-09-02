require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano_colors'

set :application, 'home-album'

set :repository, 'git@github.com:maxd/home-album.git'
set :scm, :git
set :deploy_via, :copy
set :copy_strategy, :export
set :copy_exclude, %w(.git)

role :web, '192.168.1.100'
role :db,  '192.168.1.100', primary: true

set :user, 'closer'
set :use_sudo, false

set :deploy_to, "/home/closer/apps/#{rails_env}/#{application}"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system

namespace :deploy do
   task :start do end

   task :stop do end

   task :restart, roles: :web, except: { no_release: true } do
     run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
   end

   task :configure_symlinks, :roles => :web do
     run "ln -nfs #{shared_path}/config/gallery.rb #{current_release}/config/initializers/gallery.rb"
   end
end

after 'deploy:update_code', 'deploy:configure_symlinks'
