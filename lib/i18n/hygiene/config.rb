module I18n
  module Hygiene
    class Config
      attr_writer :directories
      attr_writer :locales

      def directories
        @directories ||= []
      end

      def locales
        @locales ||= []
      end
    end
  end
end
