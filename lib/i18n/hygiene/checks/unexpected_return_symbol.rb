require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_matched_value'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < Base
        RETURN_SYMBOL_REGEX = /\u23ce/

        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales, scopes_to_exclude: config.scopes_to_exclude)
          keys_with_return_symbols = I18n::Hygiene::KeysWithMatchedValue.new(RETURN_SYMBOL_REGEX, wrapper)

          keys_with_return_symbols.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title("Unexpected return symbol (U+23CE)")
              .locale(locale)
              .key(key)
              .translation(wrapper.value(locale, key))
              .create

            yield Result.new(:failure, message: message)
          end
        end
      end
    end
  end
end
