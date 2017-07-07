module I18n
  module Hygiene
    module Checks
      class Base
        def initialize(config)
          raise "Must pass an instance of Config" unless config.is_a?(I18n::Hygiene::Config)
          @config = config
        end

        def run
          raise "#run must be implemented by subclass"
        end

        private

        def config
          @config
        end
      end
    end
  end
end
