require 'i18n/hygiene/key_usage_checker'

describe I18n::Hygiene::KeyUsageChecker do

  let(:checker_instance) { I18n::Hygiene::KeyUsageChecker.new(directories: ["yolo"]) }

  # stub system calls to ack/ag and wc
  before do
    allow(checker_instance).to receive(:ag_or_ack).and_return("ag")
    allow(checker_instance).to receive(:`).and_return(wc_result)
  end

  describe '#used?' do
    context "wc is zero" do
      let(:wc_result) { "0" }

      it "returns false" do
        expect(checker_instance.used?("my.key")).to eql false
      end

      context "key is prefixed with i18n" do
        it "returns true" do
          expect(checker_instance.used?("i18n.my.key")).to eql true
        end
      end

      context "key with recongised plural suffix" do
        it "chops plural suffix off and returns false" do
          expect(checker_instance).to receive(:fully_qualified_key_used?).with("my.key.zero").and_call_original.ordered
          expect(checker_instance).to receive(:fully_qualified_key_used?).with("my.key").and_call_original.ordered
          expect(checker_instance.used?("my.key.zero")).to eql false
        end
      end
    end

    context "wc is greater than zero" do
      let(:wc_result) { "3" }

      it "returns true" do
        expect(checker_instance.used?("my.key")).to eql true
      end

      context "key with recongised plural suffix" do
        it "chops plural suffix off and returns true" do
          expect(checker_instance).to receive(:fully_qualified_key_used?).with("my.key.zero").and_call_original.ordered
          expect(checker_instance).to receive(:fully_qualified_key_used?).with("my.key").and_call_original.ordered
          expect(checker_instance.used?("my.key.zero")).to eql true
        end
      end
    end
  end
end
