require 'rake'
require 'rake/tasklib'

module I18n
  module Hygiene
    module Tasks
      class CheckVariables < ::Rake::TaskLib
        TASK_NAME = :check_variables

        attr_accessor :check_locales

        def initialize(task_name = TASK_NAME)
          if block_given?
            yield self
          end

          unless ::Rake.application.last_description
            desc %(Check i18n hygiene)
          end

          task(task_name => dependencies) do
            puts "Checking for mismatching interpolation variables..."

            wrapper = I18n::Hygiene::Wrapper.new

            mismatched_variables = wrapper.keys_to_check.select do |key|
              checker = I18n::Hygiene::VariableChecker.new(key, wrapper, check_locales)
              checker.mismatch_details if checker.mismatched_variables_found?
            end

            mismatched_variables.each { |details| puts details }

            puts "Finished checking.\n\n"

            fail if mismatched_variables.any?
          end
        end

        private

        def dependencies
          [:environment] if defined?(Rails)
        end
      end
    end
  end
end
