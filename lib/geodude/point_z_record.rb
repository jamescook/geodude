module Geodude
  class PointZRecord < BinData::Record
    endian :little

    uint32 :shape_type, :assert => 11
    double :x
    double :y
    double :z
    double :measure
  end
end
