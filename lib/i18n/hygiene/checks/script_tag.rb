require 'i18n/hygiene/checks/unexpected_regex_match'
require 'i18n/hygiene/keys_with_script_tags'

module I18n
  module Hygiene
    module Checks
      class ScriptTag < UnexpectedRegexMatch

        protected

        def keys
          I18n::Hygiene::KeysWithScriptTags.new(i18n_wrapper: wrapper)
        end

        def title
          "Unexpected script tag"
        end
      end
    end
  end
end
