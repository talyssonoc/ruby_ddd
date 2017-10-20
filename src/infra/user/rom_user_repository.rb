require 'import'
require 'infra/base/repository'
require 'domain/user/user'

module Infra
  module User
    class ROMUserRepository < Base::Repository[:users]
      UserNotFound = Class.new(::StandardError)

      auto_struct false

      def add(user)
        to_entity(create(user))
      end

      def get_all
        map_to_entity(users).to_a
      end

      def get_by_id(id)
        map_to_entity(users.by_pk(id)).one!
      rescue ::ROM::TupleCountMismatchError
        raise UserNotFound, id
      end

      def count
        users.count
      end

      private

      def create(user)
        users.command(:create).call(to_database(user))
      end

      def map_to_entity(result_set)
        result_set.map_to(entity_class)
      end

      def to_entity(hash)
        entity_class.new(hash)
      end

      def to_database(user)
        user.attributes
      end

      def entity_class
        Domain::User::User
      end
    end
  end
end
