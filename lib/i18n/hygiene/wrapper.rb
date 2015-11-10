module I18n
  module Hygiene
    # Utility class for interacting with i18n definitions. This is not intended to be used
    # in production code - it's focus is on making the i18n data easily enumerable and
    # queryable.
    class Wrapper

      def keys_to_check(locale = :en)
        I18n::Hygiene::LocaleTranslations.new(translations[locale]).keys_to_check
      end

      def locales
        translations.keys
      end

      def key_found?(locale, key)
        I18n.with_locale(locale) do
          I18n.exists?(key)
        end
      end

      def value(locale, key)
        I18n.with_locale(locale) do
          I18n.t(key)
        end
      end

      private

      def translations
        load_translations unless @translations
        @translations ||= ::I18n.backend.send(:translations)
      end

      def load_translations
        ::I18n.backend.send(:init_translations)
      end

    end
  end
end