require 'rom'

module Infra
  module ROM
    ROMContainer = ::ROM.container(:sql, ENV['DATABASE_URL']) do |config|
      config.auto_registration(
        Pathname(__FILE__).dirname.join('..', 'database'),
        namespace: 'Infra::Database'
      )
    end
  end
end
