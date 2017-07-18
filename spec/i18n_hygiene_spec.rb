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

          translation.dynamic is unused.
          ...Checking all interpolation variables present...
          .
          translation.interpolation for locale fr_invalid is missing interpolation variable(s): qux
          ..
          en_invalid: translation.dynamic has unexpected html entity.

          fr_invalid: translation.full_key has unexpected html entity.
          Checking that no values contain script tags ...
           - en_invalid: translation.plural.one
          Finished checking.

          Checking that no values contain return symbols i.e. U+23CE ...
          - fr_invalid: translation.full_key
          Finished checking.

          i18n hygiene checks failed.
        MESSAGE
      end
    end
  end
end
