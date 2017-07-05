module I18n
  module Hygiene
    # Checks the usage of i18n keys in the TC codebase.
    #
    # TODO: This class needs some work, I had to strip out a bunch of functionality around
    # the dynamically used keys because it was all specific to TC.
    #
    # We need to add a way to configure the hygiene checks to "whitelist" certain dynamic
    # keys and so on.
    #
    # The other issue is that we hard code the folders we scan for fully qualified keys
    # which should also be configurable.
    class KeyUsageChecker

      attr_reader :key

      def initialize(key)
        @key = key
      end

      def used_in_codebase?
        fully_qualified_key_used? || i18n_config_key?
      end

      private

      def fully_qualified_key_used?(given_key = key)
        if pluralized_key_used?(given_key)
          fully_qualified_key_used?(without_last_part)
        else
          %x<#{ag_or_ack} #{given_key} app lib | wc -l>.strip.to_i > 0
        end
      end

      def ag_or_ack
        if %x<which ag | wc -l>.strip.to_i == 1
          return "ag"
        else
          return "ack --type-add=js=.coffee"
        end
      end

      def i18n_config_key?
        key.starts_with?("i18n.")
      end

      def pluralized_key_used?(key)
        [ "zero", "one", "other" ].include?(key.split(".").last)
      end

      def without_last_part
        key.split(".")[0..-2].join(".")
      end

    end

  end
end
