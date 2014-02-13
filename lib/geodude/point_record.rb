module Geodude
  class PointRecord < BinData::Record
    int32le :shape_type
    double_le  :x
    double_le  :y
  end
end
