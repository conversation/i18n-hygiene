module I18n
  module Hygiene
    module Checks
      class Base
        def initialize(config)
          @config = config
        end

        def run
          raise "#run must be implemented by subclass"
        end
      end
    end
  end
end
