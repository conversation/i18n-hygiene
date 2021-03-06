require 'i18n'
require 'i18n/hygiene/locale_translations'

module I18n
  module Hygiene
    # Utility class for interacting with i18n definitions. This is not intended to be used
    # in production code - it's focus is on making the i18n data easily enumerable and
    # queryable.
    class Wrapper

      def initialize(exclude_keys: [], exclude_scopes: [], locales: ::I18n.available_locales)
        @locales = locales
        @exclude_keys = exclude_keys
        @exclude_scopes = exclude_scopes
      end

      def keys_to_check(locale)
        I18n::Hygiene::LocaleTranslations.new(
          translations: translations[locale],
          exclude_keys: exclude_keys,
          exclude_scopes: exclude_scopes
        ).keys_to_check
      end

      def locales
        @locales
      end

      def key_found?(locale, key)
        I18n.with_locale(locale) do
          I18n.exists?(key)
        end
      end

      def value(locale, key)
        I18n.with_locale(locale) do
          I18n.t(key, resolve: false)
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

      def exclude_keys
        @exclude_keys
      end

      def exclude_scopes
        @exclude_scopes
      end

    end
  end
end
