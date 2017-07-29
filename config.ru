require 'rubygems'
require 'bundler/setup'

ENV['RACK_ENV'] ||= 'development'

require_relative 'src/boot'
require 'interfaces/web/server'

run Interfaces::Web::Server
