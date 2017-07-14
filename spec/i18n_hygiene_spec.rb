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
          Checking usage of en_invalid keys...
          (Please be patient while the codebase is searched for key usage)
          translation.dynamic is unused.
          Finished checking.

          Checking for mismatching interpolation variables...
          translation.interpolation for locale fr_invalid is missing interpolation variable(s): qux
          translation.interpolation
          Finished checking.

          Checking for phrases that contain entities but probably shouldn't...
          - en_invalid: translation.dynamic
          - fr_invalid: translation.full_key
          Finished checking.

          Checking that no values contain script tags ...
           - en_invalid: translation.plural.one
          Finished checking.

          i18n hygiene checks failed.
        MESSAGE
      end
    end
  end
end
