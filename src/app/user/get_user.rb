require 'app/base/operation'
require 'import'

module App
  module User
    class GetUser < Base::Operation
      include Import['infra.user.user_repository']

      outputs :success, :error

      def perform(user_id:)
        output :success, user_repository.get_by_id(user_id)
      end
    end
  end
end
