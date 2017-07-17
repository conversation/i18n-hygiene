module I18n
  module Hygiene
    class Result
      attr_reader :message

      def initialize(status, message: "")
        @status = status
        @message = message
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
