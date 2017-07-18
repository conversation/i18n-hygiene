require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_script_tags'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      class ScriptTag < Base
        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales)

          keys_with_script_tags = I18n::Hygiene::KeysWithScriptTags.new(i18n_wrapper: wrapper)

          keys_with_script_tags.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title("Unexpected script tag")
              .locale(locale)
              .key(key)
              .create

            yield Result.new(:failure, message: message)
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
