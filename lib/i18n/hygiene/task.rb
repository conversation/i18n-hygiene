require 'rake'
require 'rake/tasklib'
require 'i18n/hygiene/config'
require 'i18n/hygiene/reporter'

module I18n
  module Hygiene
    class Task < ::Rake::TaskLib
      def initialize(task_name = :hygiene)
        config = Config.new

        if block_given?
          yield config
        end

        reporter = Reporter.new

        unless ::Rake.application.last_description
          desc %(Check i18n hygiene)
        end

        task() do
          fail
        end
      end

      private

      def dependencies
        [:environment] if defined?(Rails)
      end
    end
  end
end

