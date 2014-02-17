module Geodude
  class IndexRecordCollection
    include Enumerable

    attr_reader :io

    def initialize(io)
      @io      = io
      io.seek(100) if io.pos.zero?
    end

    def records
      return @records if instance_variable_defined?("@records")

      @records = []
      process_file
    end

    def [](idx)
      records[idx]
    end

    def each &block
      records.each &block
    end

    def count
      records.size
    end

    private

    def process_file
      while data_remaining?
        read_next_index_record
      end

      @records
    end

    def read_next_index_record
      Geodude::IndexRecord.new.tap do |index_record|
        records.push index_record.read(io.read(8))
      end
    end

    def data_remaining?
      !io.eof?
    end
  end
end
