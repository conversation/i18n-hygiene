require 'rainbow'

module  I18n
  module Hygiene
    class ErrorMessageBuilder
      LEFT_PAD = " " * 2
      TRUNCATE_LIMIT = 48

      def initialize
        @title = "Unspecified Error"
        @key = "unknown_key"
        @locale = nil
        @translation = nil
        @location = nil
      end

      def title(title)
        @title = title
        self
      end

      def locale(locale)
        @locale = locale
        self
      end

      def key(key)
        @key = key
        self
      end

      def translation(translation)
        @translation = translation
        self
      end

      def location(location)
        @location = location
        self
      end

      def create
        s = StringIO.new
        s << "\n"
        s << Rainbow("i18n-hygiene/#{@title}:").red
        s << "\n"
        s << LEFT_PAD

        if @locale
          s << "#{@locale}."
        end

        s << @key

        if @translation
          s << ": "
          s << Rainbow("\"#{truncated_translation}\"").yellow
        end

        if @location
          s << "\n"
          s << LEFT_PAD
          s << Rainbow(@location).cyan
        end

        s << "\n"
        s.string
      end

      private

      def truncated_translation
        if @translation.length > TRUNCATE_LIMIT
          @translation[0..TRUNCATE_LIMIT] + "..."
        else
          @translation
        end
      end
    end
  end
end
