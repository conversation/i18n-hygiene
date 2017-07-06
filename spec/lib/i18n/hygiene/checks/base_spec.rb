require 'i18n/hygiene/checks/base'

RSpec.describe I18n::Hygiene::Checks::Base do
  let(:instance) { I18n::Hygiene::Checks::Base.new(double) }

  describe "#run" do
    it "raises an exception" do
      expect{instance.run}.to raise_exception "#run must be implemented by subclass"
    end
  end
end
