require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_script_tags'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'

module I18n
  module Hygiene
    module Checks
      class ScriptTag < Base
        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales)

          keys_with_script_tags = I18n::Hygiene::KeysWithScriptTags.new(i18n_wrapper: wrapper)

          keys_with_script_tags.each do |key|
            yield Result.new(:failure, message: "\n#{key} has unexpected script tag.\n")
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
