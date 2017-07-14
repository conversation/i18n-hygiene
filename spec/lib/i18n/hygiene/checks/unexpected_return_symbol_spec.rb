require 'i18n/hygiene/config'
require 'i18n/hygiene/checks/unexpected_return_symbol'

RSpec.describe I18n::Hygiene::Checks::UnexpectedReturnSymbol do
  let(:instance) { I18n::Hygiene::Checks::UnexpectedReturnSymbol.new(I18n::Hygiene::Config.new) }
  let(:return_symbol_keys_double) { instance_double(I18n::Hygiene::KeysWithReturnSymbol, each: [], any?: false) }

  describe "#run" do
    it "checks for unexpected return symbols" do
      expect(I18n::Hygiene::KeysWithReturnSymbol).to receive(:new)
        .and_return return_symbol_keys_double

      instance.run do |result|
        expect(result.passed?).to eq true
      end
    end
  end
end
