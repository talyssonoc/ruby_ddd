module Interfaces
  module Web
    module Base
      class Server < Rack::Builder
        def controller(base, controller_class)
          map(base) { run controller_class }
        end
      end
    end
  end
end
