require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/variable_checker'

module I18n
  module Hygiene
    module Checks
      class MissingInterpolationVariableCheck < Base
        def run
          puts "Checking for mismatching interpolation variables..."

          wrapper = I18n::Hygiene::Wrapper.new

          mismatched_variables = wrapper.keys_to_check.select do |key|
            checker = I18n::Hygiene::VariableChecker.new(key, wrapper, config.locales)
            checker.mismatch_details if checker.mismatched_variables_found?
          end

          mismatched_variables.each { |details| puts details }

          puts "Finished checking.\n\n"

          mismatched_variables.any?
        end
      end
    end
  end
end
