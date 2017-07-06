module I18n
  module Hygiene
    class Result
      def initialize(status)
        @status = status
      end

      def passed?
        case @status
        when :pass
          true
        when :failure
          false
        else
          raise "Unsupported status"
        end
      end
    end
  end
end
