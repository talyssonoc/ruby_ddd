require 'app/base/operation'
require 'import'

module App
  module User
    class GetAllUsers < Base::Operation
      include Import['infra.user.user_repository']

      outputs :success, :error

      private

      def perform
        users = user_repository.get_all

        output :success, users
      end
    end
  end
end
