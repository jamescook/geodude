require "tempfile"
require "pry"

module Geodude
  module Shapefile
    class Writer
      def self.from_geodude_reader(reader)
        writer = new
        writer.file_header  = reader.file_header
        reader.records.count #FIXME
        writer.records = reader.records
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
        "<Geodude::Shapefile::Writer #{object_id.to_s(16)}>"
      end

      private

      def done?
        @done
      end

      def io
        @io ||= Tempfile.new("geodude-writer")
      end

      def write(data)
        io.write(data.to_binary_s)
      end

      def write_data
        write(file_header) && write_records
        @done = true
      end

      def write_records
        records.headers.each_with_index do |header, i|
          write(header)
          write(records.records[i])
        end
      end
    end
  end
end
