require 'parallel'

module I18n
  module Hygiene
    class Config
      attr_writer :exclude_files
      attr_writer :directories
      attr_writer :file_extensions
      attr_writer :primary_locale
      attr_writer :locales
      attr_writer :keys_to_exclude
      attr_writer :concurrency
      attr_writer :scopes_to_exclude

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
        @primary_locale ||= :en
      end

      def locales
        @locales ||= ::I18n.available_locales
      end

      def all_locales
        [primary_locale] + locales
      end

      def keys_to_exclude
        @keys_to_exclude ||= []
      end

      def concurrency
        @concurrency || Parallel.processor_count
      end

      def scopes_to_exclude
        @scopes_to_exclude ||= []
      end
    end
  end
end
