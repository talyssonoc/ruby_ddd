require 'virtus'

module Domain
  module User
    class User
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :email, String
    end
  end
end
