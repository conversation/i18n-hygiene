require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::Wrapper do
  let(:wrapper) { I18n::Hygiene::Wrapper.new(keys_to_skip: []) }

  before do
    ::I18n.backend.send(:store_translations, :en, abuse_report: { button: { submit: "x" }})
  end

  describe '#keys_to_check' do
    it 'includes expected key in those retrieved for default locale' do
      expect(wrapper.keys_to_check(:en)).to include("abuse_report.button.submit")
    end
  end

  describe '#locales' do
    it 'includes expected locales' do
      [:en].each do |locale|
        expect(wrapper.locales).to include(locale)
      end
    end

    context 'provided locales' do
      let(:wrapper) { I18n::Hygiene::Wrapper.new(locales: [:en, :fr]) }

      before do
        [:fr, :es].each do |locale|
          ::I18n.backend.send(:store_translations, locale, abuse_report: { button: { submit: "x" }})
        end
      end

      it "includes only locales filtered by provided" do
        expect(wrapper.locales).to eq [:en, :fr]
      end
    end
  end
end
