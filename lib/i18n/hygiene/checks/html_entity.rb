require 'i18n/hygiene/checks/unexpected_regex_match'
require 'i18n/hygiene/keys_with_entities'

module I18n
  module Hygiene
    module Checks
      class HtmlEntity < UnexpectedRegexMatch

        protected

        def keys
          I18n::Hygiene::KeysWithEntities.new(i18nwrapper: wrapper)
        end

        def title
          "Unexpected HTML entity"
        end
      end
    end
  end
end
