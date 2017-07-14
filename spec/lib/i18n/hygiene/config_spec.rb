require 'i18n/hygiene/config'

RSpec.describe I18n::Hygiene::Config do
  let(:config) { I18n::Hygiene::Config.new }

  describe "#primary_locale=" do
    it "sets primary_locale" do
      config.primary_locale = :en
      expect(config.primary_locale).to eq :en
    end
  end

  describe "#locales=" do
    it "sets locales" do
      config.locales = [:en]
      expect(config.locales).to eq [:en]
    end
  end

  describe "#directories=" do
    it "sets directories" do
      config.directories = ["app", "lib"]
      expect(config.directories).to eq ["app", "lib"]
    end
  end
end
