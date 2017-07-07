require 'rainbow'

module I18n
  module Hygiene
    class Reporter
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
        if passed?
          puts Rainbow("i18n hygiene checks passed.").green
        else
          puts Rainbow("i18n hygiene checks failed.").red
        end
      end
    end
  end
end
