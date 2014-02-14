module Geodude
  class PointMRecord < BinData::Record
    int32le   :shape_type
    uint32le  :x
    uint32le  :y
    uint32le  :m
  end
end
