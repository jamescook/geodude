module Geodude
  class RecordCollection
    include Enumerable
    extend Forwardable

    def_delegators :enumerator, :next

    attr_reader :io, :records

    SHAPE_TYPES = {
      0   => NullShapeRecord,
      1   => PointRecord,
      3   => PolylineRecord,
      5   => PolygonRecord
=begin
      8   => :MultiPointRecord,
      11  => :PointZRecord,
      13  => :PolyLineZRecord,
      15  => :PolygonZRecord,
      18  => :MultiPointZRecord,
      21  => :PointMRecord,
      23  => :PolyLineMRecord,
      25  => :PolygonMRecord,
      28  => :MultiPointMRecord,
      31  => :MultiPatchRecord
=end
    }

    def initialize(io)
      @io      = io
      @records = []
    end

    def each &block
      if no_data_remaining?
        yield records
      else
        enumerator.each(&block)
      end
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

    def enumerator
      Enumerator.new do |enum|
        loop do
          enum.yield get_next_record
        end
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
      shape_factory(byte).new.tap do |shape_record|
        shape_record.read(io.read(length))
      end
    end

    def read_next_header
      Geodude::RecordHeader.new.tap do |header|
        header.read(io.read(8))
      end
    end

    def data_remaining?
      !io.eof?
    end

    def no_data_remaining?
      !data_remaining?
    end

    def shape_factory(byte)
      SHAPE_TYPES.fetch(byte, Geodude::UnknownRecord)
    end
  end
end

=begin
# here I am learning how shape files are put together
File.open("/Users/james/Downloads/tl_2013_us_rails/tl_2013_us_rails.shp", "r") do |file|
  $FILE_HEADER = Geodude::FileHeader.new
  $FILE_HEADER.read(file.read(100))

  while !file.eof? do
    record_header = Geodude::RecordHeader.new
    record_header.read(file.read(8))
    next_byte = BinData::Int8.read(file.read(1))

    puts record_header.inspect
    puts "next byte #{next_byte.inspect}"
    puts "length #{record_header.content_length_in_bytes}"
    file.seek(-1, IO::SEEK_CUR)

    puts "pos #{file.pos}"
    if next_byte == 0 
      x = Geodude::NullShapeRecord.new
      puts "NULL SHAPE RECORD: #{x}"
    elsif next_byte == 1
      x = Geodude::PointRecord.new
      puts "POINT RECORD: #{x}"
      x.read(file.read(12))
    elsif next_byte == 3
      x = Geodude::PolylineRecord.new
      puts "content length in bytes: #{record_header.content_length_in_bytes}"
      x.read(file.read(record_header.content_length_in_bytes ))
      puts "POLYLINE RECORD: #{x}"
    elsif next_byte == 8
      x = Geodude::MultiPointRecord.new
      puts "MULTI POINT RECORD: #{x}"
      x.read(file.read(record_header.content_length))
    else
      puts "NYI #{next_byte}"
      raise
    end
  end
end
=end


