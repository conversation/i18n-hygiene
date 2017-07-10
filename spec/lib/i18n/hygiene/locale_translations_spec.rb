require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::LocaleTranslations do
  let(:translations) { I18n::Hygiene::LocaleTranslations.new(translations: all_translations, keys_to_skip: keys_to_skip) }
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
  let(:keys_to_skip) {
    [
      "helpers.select.prompt",
      "helpers.submit.create",
      "helpers.submit.submit",
      "helpers.submit.update"
    ]
  }

  describe "#keys_to_check" do
    it "excludes keys not in our control" do
      expect(translations.keys_to_check).to eq ["foo.bar"]
    end
  end

end
