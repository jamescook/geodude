module Geodude
  class PointArray < BinData::Array
    double_le  :x
    double_le  :y
  end
end
