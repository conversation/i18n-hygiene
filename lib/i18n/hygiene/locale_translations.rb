module I18n
  module Hygiene
    # Wrap all translations for a single locale, with knowledge of the keys that
    # aren't in our control. Can return the i18n keys that **are** in our control,
    # and therefore are interesting for a variety of reasons.
    class LocaleTranslations
      # This is a default example key in the locale files that is not actually used.
      EXAMPLE_KEY = "common.greeting"

      # These are i18n keys provided by Rails. We cannot exclude them at the :helpers
      # scope level because we do have some TC i18n keys scoped within :helpers.
      NON_TC_KEYS = [
        "helpers.select.prompt",
        "helpers.submit.create",
        "helpers.submit.submit",
        "helpers.submit.update"
      ]

      def initialize(translations)
        @translations = translations
      end

      def keys_to_check
        fully_qualified_keys(translations_to_check).reject { |key|
          NON_TC_KEYS.include?(key) || EXAMPLE_KEY == key
        }.sort
      end

      private

      def translations_to_check
        @translations.reject { |k, _v| non_tc_scopes.include? k }
      end

      def non_tc_scopes
        scopes_from_rails + scopes_from_devise + scopes_from_kaminari + scopes_from_i18n_country_select + scopes_from_faker
      end

      def scopes_from_rails
        [ :activerecord, :date, :datetime, :errors, :number, :support, :time ]
      end

      def scopes_from_devise
        [ :devise ]
      end

      def scopes_from_kaminari
        [ :views ]
      end

      def scopes_from_i18n_country_select
        [ :countries ]
      end

      def scopes_from_faker
        [ :faker ]
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
