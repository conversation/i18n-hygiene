require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_return_symbol'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < Base
        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales)
          keys_with_return_symbols = I18n::Hygiene::KeysWithReturnSymbol.new(i18n_wrapper: wrapper)

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
