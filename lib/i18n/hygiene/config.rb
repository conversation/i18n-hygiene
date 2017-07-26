require 'parallel'

module I18n
  module Hygiene
    class Config
      attr_writer :exclude_files
      attr_writer :directories
      attr_writer :file_extensions
      attr_writer :primary_locale
      attr_writer :locales
      attr_writer :exclude_keys
      attr_writer :concurrency
      attr_writer :exclude_scopes

      def exclude_files
        @exclude_files ||= []
      end

      def directories
        @directories ||= []
      end

      def file_extensions
        @file_extensions ||= ["rb", "erb", "coffee", "js", "jsx"]
      end

      def primary_locale
        @primary_locale ||= ::I18n.default_locale
      end

      def locales
        @locales ||= ::I18n.available_locales
      end

      def all_locales
        [primary_locale] + locales
      end

      def exclude_keys
        @exclude_keys ||= []
      end

      def concurrency
        @concurrency || Parallel.processor_count
      end

      def exclude_scopes
        @exclude_scopes ||= []
      end
    end
  end
end
