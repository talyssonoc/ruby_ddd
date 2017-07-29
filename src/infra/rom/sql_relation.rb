require 'rom'
require 'rom-sql'
require 'mysql2'

module Infra
  module ROM
    SQLRelation = ::ROM::Relation[:sql]
  end
end
