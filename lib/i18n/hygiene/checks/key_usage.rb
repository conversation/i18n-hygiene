require 'parallel'
require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/key_usage_checker'
require 'i18n/hygiene/result'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      ##
      # Ensures that existing translations are actually used.
      class KeyUsage < Base
        def run
          key_usage_checker = I18n::Hygiene::KeyUsageChecker.new(
            directories: config.directories,
            exclude_files: config.exclude_files,
            file_extensions: config.file_extensions
          )

          wrapper = I18n::Hygiene::Wrapper.new(
            exclude_keys: config.exclude_keys,
            exclude_scopes: config.exclude_scopes
          )

          Parallel.each(wrapper.keys_to_check(config.primary_locale), in_threads: config.concurrency) do |key|
            if key_usage_checker.used?(key)
              yield Result.new(:pass, message: ".")
            else
              message = ErrorMessageBuilder.new
                .title("Unused translation")
                .key(key)
                .create

              yield Result.new(:failure, message: message)
            end
          end
        end
      end
    end
  end
end
