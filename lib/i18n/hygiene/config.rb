module I18n
  module Hygiene
    class Config
      attr_writer :directories
      attr_writer :locales
      attr_writer :whitelist

      def directories
        @directories ||= []
      end

      def locales
        @locales ||= []
      end

      def whitelist
        @whitelist ||= []
      end
    end
  end
end
