RSpec.describe "i18n-hygiene" do
  describe "running the created rake task" do
    context "checking against a valid translation" do
      let(:shell_cmd) { "rake -f spec/fixtures/Rakefile valid" }

      before do
        system("#{shell_cmd} 2> /dev/null > /dev/null")
      end

      it "returns zero" do
        expect($?.exitstatus).to eq 0
      end
    end

    context "checking against an invalid translation" do
      let(:shell_cmd) { "rake -f spec/fixtures/Rakefile invalid" }

      it "returns nonzero" do
        system("#{shell_cmd} 2> /dev/null > /dev/null")
        expect($?.exitstatus).to eq 1
      end

      it "tells us what's wrong" do
        expect {
          system("#{shell_cmd} 2> /dev/null")
        }.to output(<<~MESSAGE).to_stdout_from_any_process
          Checking usage of en_valid keys...
          (Please be patient while the codebase is searched for key usage)
          translation.dynamic is unused.
          Finished checking.

          Checking for mismatching interpolation variables...
          translation.interpolation for locale fr_invalid is missing interpolation variable(s): qux
          translation.interpolation
          Finished checking.

          Checking for phrases that contain entities but probably shouldn't...
          - fr_invalid: translation.full_key
          Finished checking.

          i18n hygiene checks failed.
        MESSAGE
      end
    end
  end
end
