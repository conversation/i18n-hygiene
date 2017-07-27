module I18n
  module Hygiene
    # Wrap all translations for a single locale, with knowledge of the keys that
    # aren't in our control. Can return the i18n keys that **are** in our control,
    # and therefore are interesting for a variety of reasons.
    class LocaleTranslations
      # These are i18n keys provided by Rails. We cannot exclude them at the :helpers
      # scope level because we do have some TC i18n keys scoped within :helpers.

      def initialize(translations:, exclude_keys:, exclude_scopes:)
        @translations = translations
        @exclude_keys = exclude_keys || []
        @exclude_scopes = exclude_scopes || []
      end

      def keys_to_check
        fully_qualified_keys(translations_to_check).reject { |key|
          exclude_keys.include?(key)
        }.sort
      end

      private

      def translations_to_check
        @translations.reject { |k, _v| exclude_scopes.include? k }
      end

      def exclude_keys
        @exclude_keys
      end

      def exclude_scopes
        @exclude_scopes
      end

      def fully_qualified_keys(hash)
        hash.inject([]) do |accum, (key, value)|
          if value.is_a?(Hash)
            accum + fully_qualified_keys(value).map do |sub_keys|
              "#{key}.#{sub_keys}"
            end
          else
            accum + [key.to_s]
          end
        end
      end
    end
  end
end
