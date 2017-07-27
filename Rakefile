require 'bundler/setup'
require 'rom/sql/rake_task'
require_relative 'src/boot'

namespace :db do
  task :setup do
    Container.resolve('persistence.rom_container')
  end
end
