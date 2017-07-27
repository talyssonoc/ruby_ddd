require 'rom'
require 'import'

module Infra
  module User
    class ROMUserRepository
      include Import[
        'domain.user.user_entity',
        'infra.rom.rom'
      ]

      def get_all
        rom.relations.users.map(&method(:build_entity))
      end

      def get_by_id(id)
        build_entity(rom.relations.users.fetch(id))
      end

      def create(attributes)
        get_by_id(rom.relations.users.insert(attributes))
      end

      private

      def build_entity(user_rom)
        user_entity.new(user_rom.to_h)
      end
    end
  end
end
