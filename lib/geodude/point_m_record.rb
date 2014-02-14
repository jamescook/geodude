module Geodude
  class PointMRecord < BinData::Record
    endian :little

    uint32  :shape_type
    double  :x
    double  :y
    double  :m
  end
end
