require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::LocaleTranslations do
  let(:translations) {
    I18n::Hygiene::LocaleTranslations.new(
      translations: all_translations,
      exclude_keys: exclude_keys,
      exclude_scopes: exclude_scopes
    )
  }
  let(:all_translations) do
    {
      activerecord: "abc",
      devise: "abc",
      views: "abc",
      helpers: { select: { prompt: "?" } },
      foo: { bar: "baz" },
    }
  end
  let(:exclude_keys) {
    [
      "helpers.select.prompt",
      "helpers.submit.create",
      "helpers.submit.submit",
      "helpers.submit.update"
    ]
  }
  let(:exclude_scopes) {
    [
      :activerecord, :devise, :views
    ]
  }

  describe "#keys_to_check" do
    it "excludes keys not in our control" do
      expect(translations.keys_to_check).to eq ["foo.bar"]
    end
  end

end
