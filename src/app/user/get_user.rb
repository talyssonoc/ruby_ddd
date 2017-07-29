require 'app/base/operation'
require 'import'

module App
  module User
    class GetUser < Base::Operation
      include Import['infra.user.user_repository']

      outputs :success, :not_found

      def perform(user_id:)
        output :success, user_repository.get_by_id(user_id)
      rescue user_repository.class::UserNotFound => e
        output :not_found, e
      end
    end
  end
end
