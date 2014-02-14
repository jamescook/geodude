module Geodude
  class PointMRecord < BinData::Record
    int32le   :shape_type
    float_le  :x
    float_le  :y
    float_le  :m
  end
end
