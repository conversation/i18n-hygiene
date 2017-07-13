require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_entities'
require 'i18n/hygiene/result'

module I18n
  module Hygiene
    module Checks
      class HtmlEntity < Base
        def run
          puts "Checking for phrases that contain entities but probably shouldn't..."

          keys_with_entities = I18n::Hygiene::KeysWithEntities.new

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
