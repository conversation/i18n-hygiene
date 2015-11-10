require 'enumerator'

module I18n
  module Hygiene
    # A collection of Strings that indicate the i18n keys in any locale that contain
    # entities which are likely to be rendered incorrectly. Only keys ending in _html
    # or _markdown may contain entities.
    #
    class KeysWithEntities
      include Enumerable

      ENTITY_REGEX = /&\w+;/

      def initialize(i18nwrapper: nil)
        @matcher = I18n::Hygiene::KeysWithMatchedValue.new(ENTITY_REGEX, i18nwrapper, reject_keys: reject_keys)
      end

      def each(&block)
        @matcher.each(&block)
      end

      private

      def reject_keys
        Proc.new { |key| key.end_with?("_html") || key.end_with?("_markdown") }
      end
    end
  end
end
