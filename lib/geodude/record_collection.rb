module Geodude
  class RecordCollection
    include Enumerable

    attr_reader :io, :records, :headers

    SHAPE_TYPES = {
      0  => NullShapeRecord,
      1  => PointRecord,
      3  => PolylineRecord,
      5  => PolygonRecord,
      8  => MultiPointRecord,
      11 => PointZRecord,
      13 => PolylineZRecord,
      15 => PolygonZRecord,
      18 => MultiPointZRecord,
      21 => PointMRecord,
      23 => PolylineMRecord,
      25 => PolygonMRecord,
      28 => MultiPointMRecord,
      31 => MultiPatchRecord
    }

    def initialize(io)
      @io      = io
      @records = []
      @headers = []

      io.seek(100) if io.pos.zero? # Skip the file header if needed
    end

    def [](idx)
      process_file if data_remaining?
      records[idx]
    end

    def each &block
      process_file

      records.each &block
    end

    def count
      process_file

      records.size
    end

    private

    def process_file
      while data_remaining?
        get_next_record
      end
    end

    def get_next_record
      header = read_next_header
      read_next_shape(header.content_length_in_bytes).tap do |record|
        records.push(record)
      end
    end

    def read_next_shape(length)
      # Read the byte and put it back since it's
      # used in the shape record
      byte = BinData::Int8.read(io.read(1))
      io.seek(-1, IO::SEEK_CUR)

      shape_factory(byte).new(:size => length).tap do |shape_record|
        if length.nonzero?
          shape_record.read(io.read(length))
        end
      end
    end

    def read_next_header
      Geodude::RecordHeader.new.tap do |header|
        headers.push header.read(io.read(8))
      end
    end

    def data_remaining?
      !io.eof?
    end

    def no_data_remaining?
      !data_remaining?
    end

    def shape_factory(byte)
      SHAPE_TYPES.fetch(byte.value, Geodude::UnknownRecord)
    end
  end
end
