require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_entities'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'

module I18n
  module Hygiene
    module Checks
      class HtmlEntity < Base
        def run
          puts "Checking for phrases that contain entities but probably shouldn't..."

          wrapper = I18n::Hygiene::Wrapper.new(locales: config.locales)

          keys_with_entities = I18n::Hygiene::KeysWithEntities.new(i18nwrapper: wrapper)

          keys_with_entities.each do |key|
            puts "- #{key}"
          end

          puts "Finished checking.\n\n"

          if keys_with_entities.any?
            yield Result.new(:failure)
          else
            yield Result.new(:pass)
          end
        end
      end
    end
  end
end
