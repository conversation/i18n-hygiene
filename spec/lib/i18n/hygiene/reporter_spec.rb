require 'i18n/hygiene/reporter'
require 'i18n/hygiene/result'

RSpec.describe I18n::Hygiene::Reporter do
  let(:reporter) { I18n::Hygiene::Reporter.new }
  let(:passed_result) { I18n::Hygiene::Result.new(:pass) }
  let(:failed_result) { I18n::Hygiene::Result.new(:failure) }

  describe "#concat" do
    it "adds a result to the stack" do
      2.times { reporter.concat passed_result }
      expect(reporter.results.count).to eq 2
    end
  end

  describe "#passed?" do
    before do
      reporter.concat(passed_result)
      reporter.concat(passed_result)
    end

    context "all reports passed" do
      it "returns true" do
        expect(reporter.passed?).to eq(true)
      end
    end

    context "one or more reports failed" do
      before do
        reporter.concat(failed_result)
        reporter.concat(passed_result)
      end

      it "returns false" do
        expect(reporter.passed?).to eq(false)
      end
    end
  end

  describe "#report" do
    context "passed" do
      before do
        reporter.concat(passed_result)
      end

      it "prints 'i18n hygiene checks passed.'" do
        expect(reporter).to receive(:puts).with(/i18n hygiene checks passed./)

        reporter.report
      end
    end

    context "failed" do
      before do
        reporter.concat(failed_result)
      end

      it "prints 'i18n hygiene checks failed.'" do
        expect(reporter).to receive(:puts).with(/i18n hygiene checks failed./)

        reporter.report
      end
    end
  end
end
