module I18n
  module Hygiene
    class Config
      attr_writer :directories
      attr_writer :locales
      attr_writer :whitelist
      attr_writer :keys_to_skip

      def directories
        @directories ||= []
      end

      def locales
        @locales ||= []
      end

      def whitelist
        @whitelist ||= []
      end
      
      def keys_to_skip
        @keys_to_skip ||= []
      end
    end
  end
end
