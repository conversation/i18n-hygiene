module I18n
  module Hygiene
    # Checks for mismatching interpolation variables. For example, if the value for an i18n key
    # as defined in :en contains an interpolation variable, the value for that key as defined
    # in any other locale must have a matching variable name.
    class VariableChecker

      # This needs deprecation
      DEFAULT_LOCALES_TO_CHECK = [ :fr ]

      def initialize(key, i18n_wrapper, locales = DEFAULT_LOCALES_TO_CHECK)
        @key = key
        @i18n_wrapper = i18n_wrapper
        @locales = locales
      end

      def mismatched_variables_found?
        @locales.each do |locale|
          if key_defined?(locale)
            return true unless variables_match?(locale)
          end
        end
        false
      end

      def mismatch_details
        if mismatched_variables_found?
          details_array = []
          @locales.each do |locale|
            if key_defined?(locale)
              details_array << mismatch_details_for_locale(locale) unless variables_match?(locale)
            end
          end
          return details_array.join("\n")
        else
          return "#{@key}: no missing interpolation variables found."
        end
      end

      private

      def mismatch_details_for_locale(locale)
        "#{@key} for locale #{locale} is missing interpolation variable(s): #{missing_variables(locale)}"
      end

      def missing_variables(locale)
        variables(:en).reject { |v| variables(locale).include?(v) }.join(', ')
      end

      def key_defined?(locale)
        @i18n_wrapper.key_found?(locale, @key)
      end

      def variables_match?(locale)
        variables(locale) == variables(:en)
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
