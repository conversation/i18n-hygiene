require 'i18n'
require 'i18n/hygiene'

describe I18n::Hygiene::KeyUsageChecker do

  describe '#used_in_codebase?' do
    it 'finds usage of fully qualified key'

    it 'finds dynamic usage of key'

    it 'finds usage of pluralized key'

    it 'does not find unused key' do
      expect(I18n::Hygiene::KeyUsageChecker.new("unused.key").used_in_codebase?).to be false
    end
  end
end
