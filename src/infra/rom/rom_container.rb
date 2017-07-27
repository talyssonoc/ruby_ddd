require 'rom'

module Infra
  module ROM
    ROMContainer = ::ROM.container(:sql, ENV['DATABASE_URL']) do |config|
      config.auto_registration(File.dirname(__FILE__), namespace: 'Infra::ROM')
    end
  end
end
