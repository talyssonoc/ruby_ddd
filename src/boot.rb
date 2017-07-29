require 'dotenv'
require 'pry'

Dotenv.load('.env', ".env.#{ENV['RACK_ENV']}")

require_relative 'container'

Container.finalize! do |container|
  LAYERS = %w[app domain infra]

  LAYERS.each do |layer|
    Dir["#{File.dirname(__FILE__)}/#{layer}/**/*.rb"].each { |file| require file }
  end

  container.namespace('app') do
    namespace('user') do
      register('get_all_users') { App::User::GetAllUsers.new }
      register('get_user') { App::User::GetUser.new }
      register('create_user') { App::User::CreateUser.new }
    end
  end

  container.namespace('domain') do
    namespace('user') do
      register('user_entity') { Domain::User::User }
    end
  end

  container.namespace('infra') do
    namespace('rom') do
      register('rom') { Infra::ROM::ROMContainer }
    end

    namespace('user') do
      register('user_repository') { Infra::User::ROMUserRepository.new }
    end
  end
end
