require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/variable_checker'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      ##
      # Looks for translations which are missing interpolation variables.
      class MissingInterpolationVariable < Base
        def run
          wrapper = I18n::Hygiene::Wrapper.new(scopes_to_exclude: config.scopes_to_exclude)

          wrapper.keys_to_check(config.primary_locale).select do |key|
            checker = I18n::Hygiene::VariableChecker.new(key, wrapper, config.primary_locale, config.locales)

            checker.mismatched_variables do |locale, key, missing_variables|
              if missing_variables.any?
                message = ErrorMessageBuilder.new
                  .title("Missing interpolation variable(s)")
                  .locale(locale)
                  .key(key)
                  .translation(wrapper.value(locale, key))
                  .expected(missing_variables.join(", "))
                  .create

                yield Result.new(:failure, message: message)
              end
            end
          end
        end
      end
    end
  end
end
