require "tempfile"

module Geodude
  module Index
    class Writer
      def self.from_geodude_reader(reader)
        writer = new
        writer.file_header  = reader.file_header
        writer.records      = reader.records
        writer.records.count # FIXME
        writer.to_s
      end

      attr_accessor :file_header, :records

      def initialize
        @records = []
      end

      def to_s
        unless done?
          write_data
        end

        @str ||= io.rewind && io.read
      end

      def inspect
        "<Geodude::Index::Writer #{object_id.to_s(16)}>"
      end

      private

      def done?
        @done
      end

      def io
        @io ||= Tempfile.new("geodude-index-writer")
      end

      def write(data)
        io.write(data.to_binary_s)
      end

      def write_data
        set_file_length
        write(file_header) && write_records
        @done = true
      end

      def set_file_length
        file_header.file_length = 50 + ( 4 * records.count )
      end

      def write_records
        offset = 50 # file header = 100bytes = 50 16bit words

        records.headers.each_with_index do |header, i|
          write(BinData::Uint32be.new(offset))
          write(BinData::Uint32be.new(header.content_length))

          # Add 4 to represent the record header (8bytes) as 16bit words
          offset = offset + (header.content_length + 4)
        end
      end
    end
  end
end
