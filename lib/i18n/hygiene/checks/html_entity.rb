require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/keys_with_matched_value'
require 'i18n/hygiene/result'
require 'i18n/hygiene/wrapper'
require 'i18n/hygiene/error_message_builder'

module I18n
  module Hygiene
    module Checks
      ##
      # Looks for unexpected HTML entities (`&amp;`, `&#33;`) in translations.
      class HtmlEntity < Base
        ENTITY_REGEX = /&\w+;/

        def run
          wrapper = I18n::Hygiene::Wrapper.new(locales: all_locales, exclude_scopes: config.exclude_scopes)

          keys_with_entities = I18n::Hygiene::KeysWithMatchedValue.new(ENTITY_REGEX, wrapper, reject_keys: reject_keys)

          keys_with_entities.each do |locale, key|
            message = ErrorMessageBuilder.new
              .title("Unexpected HTML entity")
              .locale(locale)
              .key(key)
              .translation(wrapper.value(locale, key))
              .create

            yield Result.new(:failure, message: message)
          end
        end

        private

        def reject_keys
          Proc.new { |key| key.end_with?("_html") || key.end_with?("_markdown") }
        end
      end
    end
  end
end
