require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/json'

module Interfaces
  module Web
    module Base
      class Controller < Sinatra::Base
        register Sinatra::Namespace
      end
    end
  end
end
