require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_return_symbol'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < Base
        def run
          keys_with_return_symbols = I18n::Hygiene::KeysWithReturnSymbol.new

          keys_with_return_symbols.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title("Unexpected return symbol (U+23CE)")
              .locale(locale)
              .key(key)
              .create

            yield Result.new(:failure, message: message)
          end
        end

        private

        def all_locales
          [config.primary_locale] + config.locales
        end

      end
    end
  end
end
