require 'rake'
require 'rake/tasklib'
require 'i18n/hygiene/config'
require 'i18n/hygiene/reporter'
require 'i18n/hygiene/checks/html_entity'
require 'i18n/hygiene/checks/key_usage'
require 'i18n/hygiene/checks/missing_interpolation_variable'
require 'i18n/hygiene/checks/script_tag'
require 'i18n/hygiene/checks/unexpected_return_symbol'

module I18n
  module Hygiene
    class RakeTask < ::Rake::TaskLib
      CHECKS = [
        I18n::Hygiene::Checks::KeyUsage,
        I18n::Hygiene::Checks::MissingInterpolationVariable,
        I18n::Hygiene::Checks::HtmlEntity,
        I18n::Hygiene::Checks::ScriptTag,
        I18n::Hygiene::Checks::UnexpectedReturnSymbol,
      ]

      def initialize(task_name = :hygiene)
        config = Config.new

        if block_given?
          yield config
        end

        unless ::Rake.application.last_description
          desc %(Check i18n hygiene)
        end

        task(task_name => dependencies) do
          checks = configure_checks(config)

          checks.each do |check|
            check.run do |result|
              reporter.concat(result)
            end
          end

          reporter.report

          exit(1) unless reporter.passed?
        end
      end

      private

      def reporter
        @reporter ||= Reporter.new
      end

      def configure_checks(config)
        CHECKS.map do |check|
          check.new(config)
        end
      end

      def dependencies
        [:environment] if defined?(Rails)
      end
    end
  end
end
