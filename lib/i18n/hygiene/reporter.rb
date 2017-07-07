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
          puts "i18n hygiene checks passed."
        else
          puts "i18n hygiene checks failed."
        end
      end
    end
  end
end
