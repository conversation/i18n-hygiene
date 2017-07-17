require 'rainbow'

module I18n
  module Hygiene
    class Reporter
      def concat(result)
        print_progress(result)

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

      private

      def result_color(result)
        if result.passed?
          :green
        else
          :red
        end
      end

      def print_progress(result)
        if result.message.length > 1
          puts "\n#{Rainbow(result.message).color(result_color(result))}\n\n"
        else
          print Rainbow(result.message).color(result_color(result))
        end
      end
    end
  end
end
