require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::VariableChecker do
  let(:i18n_wrapper) { instance_double("TC::I18nWrapper") }
  let(:checker) { I18n::Hygiene::VariableChecker.new("test_key", i18n_wrapper, :en, [:fr]) }
  let(:checker_markdown) { I18n::Hygiene::VariableChecker.new("test_key_markdown", i18n_wrapper, :en, [:fr]) }
  let(:base_value) { "A sentence with a variable %{variable_key}"  }
  let(:base_js_value) { "A sentence with a variable __variable_key__"  }
  let(:matching_value) { "Translation with correct variable %{variable_key}"  }
  let(:matching_js_value) { "Translation with correct variable __variable_key__"  }
  let(:mismatch) { "Translation with wrong variable %{bad_key}" }
  let(:mismatch_js) { "Translation with wrong variable __bad_key__" }
  let(:mismatch_info) { "test_key for locale fr is missing interpolation variable(s): variable_key"  }
  let(:markdown_italic_en) { "Within Markdown __italics__ ignore" }
  let(:markdown_italic_fr) { "Within Markdown __italiques__ ignore" }


  describe '#mismatched_variables_found?' do
    it 'returns true if a mismatched variable is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { mismatch }
      expect(checker.mismatched_variables_found?).to be true
    end

    it 'returns true if a mismatched variable using JS syntax is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_js_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { mismatch_js }
      expect(checker.mismatched_variables_found?).to be true
    end

    it 'returns false if no mismatched variable is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { matching_value }
      expect(checker.mismatched_variables_found?).to be false
    end

    it 'returns false if no mismatched variable using JS syntax is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_js_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { matching_js_value }
      expect(checker.mismatched_variables_found?).to be false
    end

    it 'returns false if markdown italics used in key with "_markdown" suffix' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key_markdown") { markdown_italic_en }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key_markdown") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key_markdown") { markdown_italic_fr }
      expect(checker_markdown.mismatched_variables_found?).to be false
    end

    it 'returns true if markdown italics used in key with non "_markdown" suffix' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { markdown_italic_en }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { markdown_italic_fr }
      expect(checker.mismatched_variables_found?).to be true
    end

    it 'returns false if key not defined in locale' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { false }
      expect(checker.mismatched_variables_found?).to be false
    end
  end

  describe '#mismatch_details' do
    it 'returns expected report if a mismatched variable is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { mismatch }
      expect(checker.mismatch_details).to eq(mismatch_info)
    end

    it 'returns "No mismatches found" if no mismatched variable is found' do
      allow(i18n_wrapper).to receive(:value).with(:en, "test_key") { base_value }
      allow(i18n_wrapper).to receive(:key_found?).with(:fr, "test_key") { true }
      allow(i18n_wrapper).to receive(:value).with(:fr, "test_key") { matching_value }
      expect(checker.mismatch_details).to eq("test_key: no missing interpolation variables found.")
    end
  end

end
