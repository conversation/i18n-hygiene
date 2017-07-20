require 'parallel'

module I18n
  module Hygiene
    class Config
      attr_writer :directories
      attr_writer :primary_locale
      attr_writer :locales
      attr_writer :keys_to_skip
      attr_writer :concurrency
      attr_reader :all_locales

      def directories
        @directories ||= []
      end

      def primary_locale
        @primary_locale ||= :en
      end

      def locales
        @locales ||= ::I18n.available_locales
      end

      def all_locales
        [primary_locale] + locales
      end

      def keys_to_skip
        @keys_to_skip ||= []
      end

      def concurrency
        @concurrency || Parallel.processor_count
      end
    end
  end
end
