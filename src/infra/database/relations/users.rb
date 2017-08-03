require 'infra/base/sql_relation'

module Infra
  module Database
    module Relations
      class Users < Base::SQLRelation
        schema(:users, infer: true)
      end
    end
  end
end
