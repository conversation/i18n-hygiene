require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::Wrapper do
  let(:wrapper) { I18n::Hygiene::Wrapper.new(keys_to_exclude: []) }

  before do
    [:en, :fr, :es].each do |locale|
      ::I18n.backend.send(:store_translations, locale, abuse_report: { button: { submit: "x" }})
    end
  end

  describe '#keys_to_check' do
    it 'includes expected key in those retrieved for default locale' do
      expect(wrapper.keys_to_check(:en)).to include("abuse_report.button.submit")
    end
  end

  describe '#locales' do
    it 'includes all locales by default' do
      expect(wrapper.locales).to eq [:en, :fr, :es]
    end

    context 'provided locales' do
      let(:wrapper) { I18n::Hygiene::Wrapper.new(locales: [:en, :fr]) }

      it "includes only locales provided" do
        expect(wrapper.locales).to eq [:en, :fr]
      end
    end
  end
end
