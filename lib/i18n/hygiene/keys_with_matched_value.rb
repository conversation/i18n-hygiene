module I18n
  module Hygiene
    # Checks to see if any i18n values match a given regex.
    class KeysWithMatchedValue
      include Enumerable

      def initialize(regex, i18n_wrapper = nil, reject_keys: nil)
        @regex = regex
        @i18n = i18n_wrapper || I18n::Hygiene::Wrapper.new
        @reject_keys = reject_keys
        @matching_keys = load_matching_keys
      end

      def each(&block)
        @matching_keys.each(&block)
      end

      private

      def load_matching_keys
        locales.inject([]) do |results, locale|
          results + matching_keys(locale).map { |key| "#{locale}: #{key}" }
        end
      end

      def matching_keys(locale)
        keys_to_check(locale).select { |key| i18n.value(locale, key).to_s.match(regex) }
      end

      def regex
        @regex
      end

      def keys_to_check(locale)
        reject_keys ? i18n.keys_to_check(locale).reject(&reject_keys) : i18n.keys_to_check(locale)
      end

      def reject_keys
        @reject_keys
      end

      def i18n
        @i18n
      end

      def locales
        i18n.locales
      end

    end
  end
end
