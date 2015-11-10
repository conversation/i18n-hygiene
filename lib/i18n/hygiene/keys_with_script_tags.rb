require 'enumerator'

module I18n
  module Hygiene
    # Checks to see if any i18n values contain script tags.
    # We should never allow script tags!
    class KeysWithScriptTags
      include Enumerable

      SCRIPT_TAG_REGEX = /<script>.*<\/script>/

      def initialize(i18n_wrapper: nil)
        @matcher = I18n::Hygiene::KeysWithMatchedValue.new(SCRIPT_TAG_REGEX, i18n_wrapper)
      end

      def each(&block)
        @matcher.each(&block)
      end
    end
  end
end
