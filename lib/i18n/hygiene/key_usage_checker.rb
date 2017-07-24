module I18n
  module Hygiene
    # Checks the usage of i18n keys in the codebase.
    class KeyUsageChecker

      def initialize(directories:, exclude_files: [], file_extensions: [])
        @directories = directories
        @exclude_files = exclude_files
        @file_extensions = file_extensions

        raise "Must have git installed!" unless system("which git > /dev/null")
      end

      def used?(key)
        i18n_config_key?(key) || fully_qualified_key_used?(key)
      end

      private

      def fully_qualified_key_used?(key)
        if pluralized_key_used?(key)
          fully_qualified_key_used?(without_last_part(key))
        else
          options = [git_grep_include, git_grep_exclude].reject(&:empty?).join(" ")

          %x<git grep #{key} #{options} | wc -l>.strip.to_i > 0
        end
      end

      def git_grep_include
        @directories.map { |dir|
          if @file_extensions.empty?
            dir
          else
            @file_extensions.map { |ext|
              "'#{dir}/*.#{ext}'"
            }
          end
        }.flatten.join(" ")
      end

      def git_grep_exclude
        @exclude_files.map { |file|
          "':(exclude)*#{file}'"
        }.join(" ")
      end

      def i18n_config_key?(key)
        key.start_with?("i18n.")
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
