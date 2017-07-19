require 'i18n/hygiene/key_usage_checker'

describe I18n::Hygiene::KeyUsageChecker do

  let(:checker_instance) do
    I18n::Hygiene::KeyUsageChecker.new(
      directories: ["you", "only", "yolo", "once"]
    )
  end

  describe '#used?' do
    context "key is prefixed with i18n" do
      it "returns true" do
        expect(checker_instance.used?("i18n.my.key")).to eql true
      end
    end

    context "shelling out" do
      # stub system calls to git grep and wc
      before do
        expect(checker_instance).to receive(:`).with("git grep my.key you only yolo once | wc -l").and_return(wc_result)
      end

      context "wc is zero" do
        let(:wc_result) { "0" }

        it "returns false" do
          expect(checker_instance.used?("my.key")).to eql false
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
end
