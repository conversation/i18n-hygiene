require 'rainbow'

module I18n
  module Hygiene
    class Reporter
      def initialize
        @start_time = Time.now
      end

      def concat(result)
        results.push(result)
      end

      def results
        @results ||= []
      end

      def passed?
        results.all? { |result| result.passed? }
      end

      def report
        puts "Finished in %.3f seconds." % run_time

        if passed?
          puts Rainbow("i18n hygiene checks passed.").green
        else
          puts Rainbow("i18n hygiene checks failed.").red
        end
      end

      private

      def run_time
        (Time.now - @start_time).to_f
      end
    end
  end
end
