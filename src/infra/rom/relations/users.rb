require 'infra/rom/sql_relation'

module Infra
  module ROM
    module Relations
      class Users < SQLRelation
        schema(:users, infer: true)
      end
    end
  end
end
