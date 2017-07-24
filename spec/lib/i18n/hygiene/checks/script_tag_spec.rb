require 'i18n/hygiene/config'
require 'i18n/hygiene/checks/script_tag'

RSpec.describe I18n::Hygiene::Checks::ScriptTag do
  let(:instance) { I18n::Hygiene::Checks::ScriptTag.new(I18n::Hygiene::Config.new) }
  let(:keys_with_script_tags_double) { instance_double(I18n::Hygiene::KeysWithMatchedValue, each: [], any?: false) }

  describe "#run" do
    it "checks for missing interpolation variables in the configured locales" do
      expect(I18n::Hygiene::KeysWithMatchedValue).to receive(:new)
        .and_return keys_with_script_tags_double

      instance.run do |result|
        expect(result.passed?).to eq true
      end
    end
  end
end
