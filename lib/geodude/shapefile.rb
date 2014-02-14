module Geodude
  class Shapefile
    attr_reader :file

    def initialize(path)
      @file = File.open(path, "rb")
    end

    def file_header
      @file_header ||= Geodude::FileHeader.new.tap do |file_header|
        file_header.read(file.read(100))
      end
    end

    def records
      file_header if file.pos.zero?

      RecordCollection.new(file)
    end
  end
end
