require 'i18n/hygiene/checks/base'
require 'i18n/hygiene/config'

RSpec.describe I18n::Hygiene::Checks::Base do
  let(:config) { I18n::Hygiene::Config.new }
  let(:instance) { I18n::Hygiene::Checks::Base.new(config) }

  context "not given a Config" do
    it "raises an exception" do
      expect{I18n::Hygiene::Checks::Base.new(123)}.to raise_exception "Must pass an instance of Config"
    end
  end

  describe "#run" do
    it "raises an exception" do
      expect{instance.run}.to raise_exception "#run must be implemented by subclass"
    end
  end
end
