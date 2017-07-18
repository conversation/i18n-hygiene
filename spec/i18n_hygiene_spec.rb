RSpec.describe "i18n-hygiene" do
  describe "running the created rake task" do
    context "checking against a valid translation" do
      let(:shell_cmd) { "rake -f spec/fixtures/valid.Rakefile" }

      before do
        system("#{shell_cmd} 2> /dev/null > /dev/null")
      end

      it "returns zero" do
        expect($?.exitstatus).to eq 0
      end
    end

    context "checking against an invalid translation" do
      let(:shell_cmd) { "rake -f spec/fixtures/invalid.Rakefile" }

      it "returns nonzero" do
        system("#{shell_cmd} 2> /dev/null > /dev/null")
        expect($?.exitstatus).to eq 1
      end

      it "tells us what's wrong" do
        expect {
          system("#{shell_cmd} 2> /dev/null")
        }.to output(<<~MESSAGE).to_stdout_from_any_process

          i18n-hygiene/Unused Translation:
            translation.dynamic
          ....
          i18n-hygiene/Missing Interpolation Variable(s):
            fr_invalid.translation.interpolation
              Expected: qux
          ..
          i18n-hygiene/Unexpected HTML entity:
            en_invalid: translation.dynamic

          i18n-hygiene/Unexpected HTML entity:
            fr_invalid: translation.full_key

          en_invalid: translation.plural.one has unexpected script tag.

          fr_invalid: translation.full_key has unexpected return symbol (U+23CE).

          i18n hygiene checks failed.
        MESSAGE
      end
    end
  end
end
