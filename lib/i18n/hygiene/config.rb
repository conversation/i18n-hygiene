require 'parallel'

module I18n
  module Hygiene
    class Config
      attr_writer :exclude_files
      attr_writer :directories
      attr_writer :primary_locale
      attr_writer :locales
      attr_writer :keys_to_skip
      attr_writer :concurrency

      def exclude_files
        @exclude_files ||= []
      end

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

      def concurrency
        @concurrency || Parallel.processor_count
      end
    end
  end
end
