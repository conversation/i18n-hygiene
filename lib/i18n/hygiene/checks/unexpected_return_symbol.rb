require 'i18n/hygiene/checks/unexpected_regex_match'
require 'i18n/hygiene/keys_with_return_symbol'

module I18n
  module Hygiene
    module Checks
      class UnexpectedReturnSymbol < UnexpectedRegexMatch

        protected

        def keys
          I18n::Hygiene::KeysWithReturnSymbol.new(i18n_wrapper: wrapper)
        end

        def title
          "Unexpected return symbol (U+23CE)"
        end
      end
    end
  end
end
