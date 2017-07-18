require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_entities'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'

module I18n
  module Hygiene
    module Checks
      class HtmlEntity < Base
        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales)

          keys_with_entities = I18n::Hygiene::KeysWithEntities.new(i18nwrapper: wrapper)

          keys_with_entities.each do |key|
            yield Result.new(:failure, message: "\n#{key} has unexpected html entity.\n")
          end
        end

        private

        def all_locales
          [config.primary_locale] + config.locales
        end
      end
    end
  end
end
