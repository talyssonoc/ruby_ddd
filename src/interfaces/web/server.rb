require_relative 'base/server'
require_relative 'user/users_controller'

module Interfaces
  module Web
    Server = Base::Server.new do
      controller '/users', User::UsersController
    end
  end
end
