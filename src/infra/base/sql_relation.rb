require 'rom'
require 'rom-sql'
require 'mysql2'

module Infra
  module Base
    SQLRelation = ::ROM::Relation[:sql]
  end
end
