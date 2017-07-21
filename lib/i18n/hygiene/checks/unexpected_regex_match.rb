require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      class UnexpectedRegexMatch < Base
        def run
          keys.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title(title)
              .locale(locale)
              .key(key)
              .translation(wrapper.value(locale, key))
              .create

            yield Result.new(:failure, message: message)
          end
        end
          
        protected

        def wrapper
          I18n::Hygiene::Wrapper.new(locales: all_locales)
        end

        def keys
          raise "#keys must be implemented by subclass"
        end

        def title
          raise "#title must be implemented by subclass"
        end
      end
    end
  end
end
