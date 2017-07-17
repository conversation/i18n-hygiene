module I18n
  module Hygiene
    class Config
      attr_writer :directories
      attr_writer :primary_locale
      attr_writer :locales
      attr_writer :keys_to_skip

      def directories
        @directories ||= []
      end

      def primary_locale
        @primary_locale ||= :en
      end

      def locales
        @locales ||= []
      end

      def keys_to_skip
        @keys_to_skip ||= []
      end
    end
  end
end
