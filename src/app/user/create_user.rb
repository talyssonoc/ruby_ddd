require 'import'
require 'app/base/operation'

module App
  module User
    class CreateUser < Base::Operation
      include Import['infra.user.user_repository']

      outputs :success, :error

      def perform(user_params)
        output :success, user_repository.create(user_params)
      end
    end
  end
end
