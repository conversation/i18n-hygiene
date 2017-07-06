require 'i18n/hygiene/result'

RSpec.describe I18n::Hygiene::Result do
  describe "#passed?" do
    context "failure" do
      it "returns false" do
        expect(I18n::Hygiene::Result.new(:failure).passed?).to eq false
      end
    end

    context "pass" do
      it "returns true" do
        expect(I18n::Hygiene::Result.new(:pass).passed?).to eq true
      end
    end

    context "unsupported status" do
      it "raises an exception" do
        expect{I18n::Hygiene::Result.new(:yolo).passed?}.to raise_exception "Unsupported status"
      end
    end
  end
end
