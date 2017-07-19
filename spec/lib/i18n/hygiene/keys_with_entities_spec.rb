require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::KeysWithEntities do
  describe "#to_a" do
    context "when one key that shouldn't contains an HTML entity" do
      let(:locales) { [:en, :fr] }
      let(:keys_to_check) { %w[foo bar foo_html foo_markdown] }
      let(:i18nwrapper) { instance_double(I18n::Hygiene::Wrapper, locales: locales, keys_to_check: keys_to_check) }
      let(:collection) { I18n::Hygiene::KeysWithEntities.new(i18nwrapper: i18nwrapper) }

      before do
        allow(i18nwrapper).to receive(:value).with(:en, "foo") { "one two" }
        allow(i18nwrapper).to receive(:value).with(:en, "bar") { "one&nbsp;two" }
        allow(i18nwrapper).to receive(:value).with(:en, "foo_html") { "one&nbsp;two" }
        allow(i18nwrapper).to receive(:value).with(:en, "foo_markdown") { "one&nbsp;two" }
        allow(i18nwrapper).to receive(:value).with(:fr, "foo") { "one&ngsp;two" }
        allow(i18nwrapper).to receive(:value).with(:fr, "foo_html") { "one&ngsp;two" }
        allow(i18nwrapper).to receive(:value).with(:fr, "foo_markdown") { "one&ngsp;two" }
        allow(i18nwrapper).to receive(:value).with(:fr, "bar") { "one two" }
      end

      it "returns the appropriate result" do
        expect(collection.to_a).to eq [[:en, "bar"], [:fr, "foo"]]
      end
    end
  end
end
