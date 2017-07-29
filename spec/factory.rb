require 'rom-factory'
require 'container'

rom = Container['infra.rom.rom']

Factory = ROM::Factory.configure do |config|
  config.rom = rom
end
