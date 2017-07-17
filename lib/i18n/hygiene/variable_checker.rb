module I18n
  module Hygiene
    # Checks for mismatching interpolation variables. For example, if the value for an i18n key
    # as defined in :en contains an interpolation variable, the value for that key as defined
    # in any other locale must have a matching variable name.
    class VariableChecker
      def initialize(key, i18n_wrapper, primary_locale, locales = [])
        @key = key
        @i18n_wrapper = i18n_wrapper
        @primary_locale = primary_locale
        @locales = locales
      end

      def mismatched_variables
        @locales.each do |locale|
          yield(locale, @key, missing_variables(locale))
        end
      end

      private

      def missing_variables(locale)
        return [] unless key_defined?(locale)

        variables(@primary_locale).reject { |v| variables(locale).include?(v) }
      end

      def key_defined?(locale)
        @i18n_wrapper.key_found?(locale, @key)
      end

      def variables(locale)
        collect_variables(@i18n_wrapper.value(locale, @key))
      end

      def collect_variables(string)
        return [] unless string.is_a?(String)
        (rails_variables(string) + js_variables(string)).uniq.sort
      end

      def rails_variables(string)
        string.scan(/%{\S+}/).map { |var_string| var_string.gsub(/[%{}]/, '').to_sym }
      end

      def js_variables(string)
        without_markdown_italics(string.scan(/__\S+__/).map { |var_string| var_string.gsub("__", "").to_sym })
      end

      def without_markdown_italics(array)
        @key.end_with?("_markdown") ? [] : array
      end

    end

  end
end
