require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::LocaleTranslations do
  let(:translations) { I18n::Hygiene::LocaleTranslations.new(all_translations) }
  let(:all_translations) do
    {
      activerecord: "abc",
      devise: "abc",
      views: "abc",
      common: { greeting: "Hello!" },
      helpers: { select: { prompt: "?" } },
      foo: { bar: "baz" },
    }
  end

  describe "#keys_to_check" do
    it "excludes keys not in our control" do
      expect(translations.keys_to_check).to eq ["foo.bar"]
    end
  end

end
