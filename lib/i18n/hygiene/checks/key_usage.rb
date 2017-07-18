require 'parallel'
require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/key_usage_checker'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class KeyUsage < Base
        def run
          key_usage_checker = I18n::Hygiene::KeyUsageChecker.new(directories: config.directories)
          wrapper = I18n::Hygiene::Wrapper.new(keys_to_skip: config.keys_to_skip)

          Parallel.each(wrapper.keys_to_check(config.primary_locale), in_threads: config.concurrency) do |key|
            if key_usage_checker.used?(key)
              yield Result.new(:pass, message: ".")
            else
              yield Result.new(:failure, message: "\n#{key} is unused.\n")
            end
          end
        end
      end
    end
  end
end
