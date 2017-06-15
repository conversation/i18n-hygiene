require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::KeysWithScriptTags do
  describe "#to_a" do
    let(:locales) { [:en, :fr] }
    let(:keys_to_check) { %w[foo bar] }
    let(:i18n_wrapper) { instance_double(I18n::Hygiene::Wrapper, locales: locales, keys_to_check: keys_to_check) }
    let(:collection) { I18n::Hygiene::KeysWithScriptTags.new(i18n_wrapper: i18n_wrapper) }

    before do
      allow(i18n_wrapper).to receive(:value).with(:en, "foo") { "one two" }
      allow(i18n_wrapper).to receive(:value).with(:en, "bar") { "<script>one two</script>" }
      allow(i18n_wrapper).to receive(:value).with(:fr, "foo") { "<script>one two</script>" }
      allow(i18n_wrapper).to receive(:value).with(:fr, "bar") { "one two" }
    end

    it "returns keys that include script tags" do
      expect(collection.to_a).to eq(["en: bar", "fr: foo"])
    end
  end
end
