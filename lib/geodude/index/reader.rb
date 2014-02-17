module Geodude
  module Index
    class Reader
      attr_reader :file

      def initialize(path)
        @file = File.open(path, "rb:ISO8859-1")
      end

      def file_header
        @file_header ||= Geodude::FileHeader.new.tap do |file_header|
          file_header.read(file.read(100))
        end
      end

      def records
        @records ||= Geodude::IndexRecordCollection.new(file)
      end
    end
  end
end
