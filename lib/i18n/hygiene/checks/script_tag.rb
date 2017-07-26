require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_matched_value'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      ##
      # Looks for unexpected script tags in translations.
      class ScriptTag < Base
        SCRIPT_TAG_REGEX = /<script.*/

        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales, scopes_to_exclude: config.scopes_to_exclude)

          keys_with_script_tags = I18n::Hygiene::KeysWithMatchedValue.new(SCRIPT_TAG_REGEX, wrapper)

          keys_with_script_tags.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title("Unexpected script tag")
              .locale(locale)
              .key(key)
              .translation(wrapper.value(locale, key))
              .create

            yield Result.new(:failure, message: message)
          end
        end
      end
    end
  end
end
