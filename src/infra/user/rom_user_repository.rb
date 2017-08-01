require 'import'

module Infra
  module User
    class ROMUserRepository
      include Import[
        'domain.user.user_entity',
        'infra.rom.rom'
      ]

      UserNotFound = Class.new(::StandardError)

      def get_all
        users.map(&method(:build_entity))
      end

      def get_by_id(id)
        build_entity(users.fetch(id))
      rescue ::ROM::TupleCountMismatchError
        raise UserNotFound, id
      end

      def create(attributes)
        get_by_id(users.insert(attributes))
      end

      def count
        users.count
      end

      private

      def users
        rom.relations.users
      end

      def build_entity(user_rom)
        user_entity.new(user_rom.to_h)
      end
    end
  end
end
