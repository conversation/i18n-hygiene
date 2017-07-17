require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_return_symbol'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < Base
        def run
          puts "Checking that no values contain return symbols i.e. U+23CE ..."

          keys_with_return_symbols = I18n::Hygiene::KeysWithReturnSymbol.new

          keys_with_return_symbols.each do |key|
            puts "- #{key}"
          end

          puts "Finished checking.\n\n"

          if keys_with_return_symbols.any?
            yield Result.new(:failure)
          else
            yield Result.new(:pass)
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
