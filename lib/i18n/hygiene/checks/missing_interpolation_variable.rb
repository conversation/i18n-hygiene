require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/variable_checker'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class MissingInterpolationVariable < Base
        def run
          puts "Checking all interpolation variables present..."

          wrapper = I18n::Hygiene::Wrapper.new

          wrapper.keys_to_check(config.primary_locale).select do |key|
            checker = I18n::Hygiene::VariableChecker.new(key, wrapper, config.primary_locale, config.locales)

            checker.mismatched_variables do |locale, key, missing_variables|
              if missing_variables.any?
                yield Result.new(:failure, message: failure_message(locale, key, missing_variables))
              else
                yield Result.new(:pass, message: ".")
              end
            end
          end
        end

        private

        def failure_message(locale, key, missing_variables)
          "\n#{key} for locale #{locale} is missing interpolation variable(s): #{missing_variables.join(", ")}\n"
        end
      end
    end
  end
end
