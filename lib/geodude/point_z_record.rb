module Geodude
  class PointZRecord < BinData::Record
    int32le  :shape_type
    float_le :x
    float_le :y
    float_le :z
    float_le :measure
  end
end
