module I18n
  module Hygiene
    # Checks the usage of i18n keys in the codebase.
    class KeyUsageChecker

      def initialize(directories:, exclude_files: [], file_extensions: [])
        @directories = directories
        @exclude_files = exclude_files
        @file_extensions = file_extensions
      end

      def used?(key)
        fully_qualified_key_used?(key)
      end

      private

      def fully_qualified_key_used?(key)
        if pluralized_key_used?(key)
          fully_qualified_key_used?(without_last_part(key))
        else
          directories = @directories.join(" ")
          include_argument = @file_extensions.map { |extension| "--include=\"*.#{extension}\"" }.join(" ")
          exclude_argument = @exclude_files.map { |file| "--exclude=\"#{file}\"" }.join(" ")

          grep_command = [
            "grep --recursive",
            key,
            include_argument,
            exclude_argument,
            directories
          ].reject(&:empty?).join(" ")

          %x<#{grep_command} | wc -l>.strip.to_i > 0
        end
      end

      def pluralized_key_used?(key)
        [ "zero", "one", "other" ].include?(key.split(".").last)
      end

      def without_last_part(key)
        key.split(".")[0..-2].join(".")
      end

    end

  end
end
