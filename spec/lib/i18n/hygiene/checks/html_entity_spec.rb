require 'i18n/hygiene/config'
require 'i18n/hygiene/checks/html_entity'

RSpec.describe I18n::Hygiene::Checks::HtmlEntity do
  let(:instance) { I18n::Hygiene::Checks::HtmlEntity.new(I18n::Hygiene::Config.new) }
  let(:keys_with_entities_double) { instance_double(I18n::Hygiene::KeysWithEntities, each: [], any?: false) }

  describe "#run" do
    it "checks for missing interpolation variables in the configured locales" do
      expect(I18n::Hygiene::KeysWithEntities).to receive(:new)
        .and_return keys_with_entities_double

      instance.run do |result|
        expect(result.passed?).to eq true
      end
    end
  end
end
