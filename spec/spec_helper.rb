require 'rubygems'
require 'bundler/setup'

ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../src/boot', __FILE__)

require 'rack/test'
require 'database_cleaner'
require 'factory'


Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |file| require file }


module ControllerTest
  include Rack::Test::Methods

  def app
    described_class
  end

  def json
    @json ||= JSON.parse(last_response.body)
  end
end

module FactoryMixin
  def create(resource, attributes)
    Factory[resource, attributes]
  end
end

RSpec.configure do |config|
  config.include FactoryMixin
  config.include ControllerTest, type: :controller

  config.before(:suite) do
    conn = Container['infra.rom.rom'].gateways[:default].connection

    DatabaseCleaner[:sequel, connection: conn].strategy = :transaction
    DatabaseCleaner[:sequel, connection: conn].clean_with(:truncation)
  end

  config.around(:each) do |example|
    conn = Container['infra.rom.rom'].gateways[:default].connection

    DatabaseCleaner[:sequel, connection: conn].cleaning { example.run }
  end
end
