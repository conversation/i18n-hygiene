module I18n
  module Hygiene
    # Checks the usage of i18n keys in the codebase.
    class KeyUsageChecker

      def initialize(directories:)
        @directories = directories
        @tool = ag_or_ack
      end

      def used?(key)
        i18n_config_key?(key) || fully_qualified_key_used?(key)
      end

      private

      def fully_qualified_key_used?(key)
        if pluralized_key_used?(key)
          fully_qualified_key_used?(without_last_part(key))
        else
          %x<#{@tool} #{key} #{@directories.join(" ")} | wc -l>.strip.to_i > 0
        end
      end

      def ag_or_ack
        if system("which ag > /dev/null")
          return "ag"
        elsif system("which ack > /dev/null")
          return "ack --type-add=js=.coffee"
        else
          raise "Must have either ag (silversearcher-ag) or ack installed."
        end
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
