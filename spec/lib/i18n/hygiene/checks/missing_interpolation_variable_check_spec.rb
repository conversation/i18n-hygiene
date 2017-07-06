require 'i18n/hygiene/config'
require 'i18n/hygiene/checks/missing_interpolation_variable_check'

RSpec.describe I18n::Hygiene::Checks::MissingInterpolationVariableCheck do
  let(:config) { I18n::Hygiene::Config.new.tap { |config| config.locales = [:en, :es, :fr] } }
  let(:instance) { I18n::Hygiene::Checks::MissingInterpolationVariableCheck.new(config) }
  let(:wrapper_double) { instance_double(I18n::Hygiene::Wrapper, keys_to_check: ["blah"]) }
  let(:variable_checker_double) { instance_double(I18n::Hygiene::VariableChecker, mismatched_variables_found?: false) }

  describe "#run" do
    before do
      allow(I18n::Hygiene::Wrapper).to receive(:new).and_return wrapper_double
    end

    it "checks for missing interpolation variables in the configured locales" do
      expect(I18n::Hygiene::VariableChecker).to receive(:new)
        .with(String, wrapper_double, [:en, :es, :fr]).and_return variable_checker_double

      instance.run
    end
  end
end
