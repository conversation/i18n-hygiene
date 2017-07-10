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
          puts "Checking usage of EN keys..."
          puts "(Please be patient while the codebase is searched for key usage)"

          key_usage_checker = I18n::Hygiene::KeyUsageChecker.new(
            directories: config.directories,
            whitelist: config.whitelist
          )

          unused_keys = Parallel.map(I18n::Hygiene::Wrapper.new.keys_to_check) { |key|
            key unless key_usage_checker.used?(key)
          }.compact

          unused_keys.each do |key|
            puts "#{key} is unused."
          end

          puts "Finished checking.\n\n"

          if unused_keys.any?
            yield Result.new(:failure)
          else
            yield Result.new(:pass)
          end
        end
      end
    end
  end
end
