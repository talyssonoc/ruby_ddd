require 'rubygems'
require 'bundler/setup'
require 'dotenv/load'

Bundler.require(:default, ENV['RACK_ENV'])

require_relative 'src/boot'

server = Container['interfaces.web.server']

run server
