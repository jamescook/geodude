require "bindata"
require_relative "./geodude/file_header"
require_relative "./geodude/record_header"
require_relative "./geodude/point_array"
require_relative "./geodude/part_array"
require_relative "./geodude/box"
require_relative "./geodude/null_shape_record"
require_relative "./geodude/point_record"
require_relative "./geodude/multi_point_record"
require_relative "./geodude/polyline_record"
require_relative "./geodude/shapefile"

module Geodude
  SHAPE_TYPES = {
    0   => :NullShapeRecord,
    1   => :PointRecord,
    3   => :PolylineRecord,
    5   => :PolygonRecord,
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
  }
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


=begin
Position Field        Value       Type    Order
Byte 0   File Code    9994        Integer Big
Byte 4   Unused       0           Integer Big
Byte 8   Unused       0           Integer Big
Byte 12  Unused       0           Integer Big
Byte 16  Unused       0           Integer Big
Byte 20  Unused       0           Integer Big
Byte 24  File Length  File Length Integer Big
Byte 28  Version      1000        Integer Little
Byte 16  Shape Type   Shape Type  Integer Little
Byte 36  Bounding Box Xmin        Double  Little
Byte 44  Bounding Box Ymin        Double  Little
Byte 52  Bounding Box Xmax        Double  Little
Byte 60  Bounding Box Ymax        Double  Little
Byte 68* Bounding Box Zmin        Double  Little
Byte 76* Bounding Box Zmax        Double  Little
Byte 84* Bounding Box Mmin        Double  Little
Byte 92* Bounding Box Mmax        Double  Little

Value Shape Type
0     Null Shape
1     Point
3     PolyLine
5     Polygon
8     MultiPoint
11    PointZ
13    PolyLineZ
15    PolygonZ
18    MultiPointZ
21    PointM
23    PolyLineM
25    PolygonM
28    MultiPointM
31    MultiPatch
=end
