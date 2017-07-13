require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/variable_checker'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class MissingInterpolationVariable < Base
        def run
          puts "Checking for mismatching interpolation variables..."

          wrapper = I18n::Hygiene::Wrapper.new(keys_to_skip: config.keys_to_skip)

          mismatched_variables = wrapper.keys_to_check(config.primary_locale).select do |key|
            checker = I18n::Hygiene::VariableChecker.new(key, wrapper, config.primary_locale, config.locales)
            checker.mismatch_details if checker.mismatched_variables_found?
          end

          mismatched_variables.each { |details| puts details }

          puts "Finished checking.\n\n"

          if mismatched_variables.any?
            yield Result.new(:failure)
          else
            yield Result.new(:pass)
          end
        end
      end
    end
  end
end
