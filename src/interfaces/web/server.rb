require_relative 'base/controller'
require_relative 'user/users_controller'

module Interfaces
  module Web
    class Server < Base::Controller
      use User::UsersController
    end
  end
end
