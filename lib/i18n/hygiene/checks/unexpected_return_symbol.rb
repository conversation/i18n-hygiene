require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_return_symbol'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < Base
        def run
          keys_with_return_symbols = I18n::Hygiene::KeysWithReturnSymbol.new

          keys_with_return_symbols.each do |key|
            yield Result.new(:failure, message: "\n#{key} has unexpected return symbol (U+23CE).\n")
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
