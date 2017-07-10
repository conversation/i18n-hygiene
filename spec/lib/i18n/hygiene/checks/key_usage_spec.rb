require 'i18n/hygiene/config'
require 'i18n/hygiene/checks/key_usage'

RSpec.describe I18n::Hygiene::Checks::KeyUsage do
  let(:config) { I18n::Hygiene::Config.new.tap { |config| config.directories = ["app", "lib"] } }
  let(:instance) { I18n::Hygiene::Checks::KeyUsage.new(config) }
  let(:wrapper_double) { instance_double(I18n::Hygiene::Wrapper, keys_to_check: ["blah"]) }
  let(:key_usage_checker_double) { instance_double(I18n::Hygiene::KeyUsageChecker, used?: true) }

  describe "#run" do
    before do
      allow(I18n::Hygiene::Wrapper).to receive(:new).and_return wrapper_double
    end

    it "checks for missing interpolation variables in the configured locales" do
      expect(I18n::Hygiene::KeyUsageChecker).to receive(:new)
        .with(directories: ["app", "lib"], whitelist: []).and_return key_usage_checker_double

      instance.run do |result|
        expect(result.passed?).to eq true
      end
    end
  end
end
