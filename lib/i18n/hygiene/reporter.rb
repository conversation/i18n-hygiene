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
    end
  end
end
