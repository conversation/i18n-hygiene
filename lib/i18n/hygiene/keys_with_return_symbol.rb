require 'enumerator'

module I18n
  module Hygiene
    # Checks to see if any i18n values contain the U+23CE character.
    # It has been included in PhraseApp translations but is unwanted.
    class KeysWithReturnSymbol
      include Enumerable

      RETURN_SYMBOL_REGEX = /\u23ce/

      def initialize(i18n_wrapper: nil)
        @matcher = I18n::Hygiene::KeysWithMatchedValue.new(RETURN_SYMBOL_REGEX, i18n_wrapper)
      end

      def each(&block)
        @matcher.each(&block)
      end
    end
  end
end
