require 'dry/system/container'

class Container < Dry::System::Container
  configure do |config|
    config.system_dir = 'src'
    config.root = Pathname(__FILE__).dirname.join('..').realpath
  end

  load_paths!
end
