require 'rake'
require 'rake/tasklib'
require 'i18n/hygiene/config'
require 'i18n/hygiene/reporter'
require 'i18n/hygiene/checks/missing_interpolation_variable_check'

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

        task(task_name => dependencies) do
          checker = I18n::Hygiene::Checks::MissingInterpolationVariableCheck.new(config)
          result = checker.run
          fail unless result.passed?
        end
      end

      private

      def dependencies
        [:environment] if defined?(Rails)
      end
    end
  end
end

